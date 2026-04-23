import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:phone_state/phone_state.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/data/recorder/audio_recorder_engine.dart';
import 'package:support_call_recorder/data/security/file_crypto.dart';
import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';
import 'package:support_call_recorder/domain/usecase/call_recording_usecases.dart';
import 'package:support_call_recorder/telephony/native_call_bridge.dart';

typedef ExcludedNumbersReader = List<String> Function();

class CallMonitorService {
  CallMonitorService({
    required CallRecordingUseCases useCases,
    required AudioRecorderEngine engine,
    required FileCrypto fileCrypto,
    required PermissionService permissionService,
    required NativeCallBridge nativeBridge,
    required ExcludedNumbersReader readExcludedNumbers,
  })  : _useCases = useCases,
        _engine = engine,
        _fileCrypto = fileCrypto,
        _permissionService = permissionService,
        _nativeBridge = nativeBridge,
        _readExcludedNumbers = readExcludedNumbers;

  final CallRecordingUseCases _useCases;
  final AudioRecorderEngine _engine;
  final FileCrypto _fileCrypto;
  final PermissionService _permissionService;
  final NativeCallBridge _nativeBridge;
  final ExcludedNumbersReader _readExcludedNumbers;

  StreamSubscription<PhoneState>? _subscription;
  DateTime? _activeStart;
  String _activeNumber = 'unknown';
  File? _activeFile;
  String _activeSource = 'unknown';
  final _recordingStateController =
      StreamController<ActiveRecordingState>.broadcast();

  Stream<ActiveRecordingState> get recordingStateStream =>
      _recordingStateController.stream;

  ActiveRecordingState get currentRecordingState => ActiveRecordingState(
        isRecording: _activeStart != null,
        phoneNumber: _activeNumber,
        startedAt: _activeStart,
      );

  Future<void> start() async {
    if (_subscription != null) return;
    final allowed = await _permissionService.ensureRequired();
    if (!allowed) return;
    final serviceStarted = await _nativeBridge.startForegroundCallService();
    if (!serviceStarted) return;

    _subscription ??= PhoneState.stream.listen((event) async {
      try {
        if (event.status == PhoneStateStatus.CALL_STARTED) {
          await _onCallStarted(event.number ?? 'unknown');
        }
        if (event.status == PhoneStateStatus.CALL_ENDED) {
          await _onCallEnded();
        }
      } catch (_) {
        // Avoid terminating the stream listener on recording errors.
      }
    });
  }

  Future<void> stop() async {
    await _finishActiveRecording();
    await _subscription?.cancel();
    _subscription = null;
    await _nativeBridge.stopForegroundCallService();
  }

  void dispose() {
    _recordingStateController.close();
  }

  Future<void> stopActiveRecording() async {
    await _finishActiveRecording();
  }

  Future<void> _onCallStarted(String number) async {
    if (_activeStart != null) return;
    if (_isExcludedNumber(number)) return;
    final dir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = p.join(dir.path, 'calls', 'call_$timestamp.m4a');
    final file = File(path);
    await file.parent.create(recursive: true);
    try {
      _activeSource = await _engine.start(file);
      _activeStart = DateTime.now();
      _activeNumber = number;
      _activeFile = file;
      _emitRecordingState();
    } catch (_) {
      _activeStart = null;
      _activeFile = null;
      _activeSource = 'unknown';
      _emitRecordingState();
    }
  }

  bool _isExcludedNumber(String incomingNumber) {
    final excluded = _normalizePhoneNumberList();
    if (excluded.isEmpty) return false;
    final normalizedIncoming = _normalizePhoneNumber(incomingNumber);
    return excluded.contains(normalizedIncoming);
  }

  Set<String> _normalizePhoneNumberList() {
    return _readExcludedNumbers()
        .map(_normalizePhoneNumber)
        .where((value) => value.isNotEmpty)
        .toSet();
  }

  String _normalizePhoneNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    return digitsOnly.isEmpty ? value.trim() : digitsOnly;
  }

  Future<void> _onCallEnded() async {
    await _finishActiveRecording();
  }

  Future<void> _finishActiveRecording() async {
    final started = _activeStart;
    final file = _activeFile;
    if (started == null || file == null) return;
    await _engine.stop();
    await _fileCrypto.encryptInPlace(file);
    final ended = DateTime.now();
    await _useCases.save(
      CallRecording(
        id: null,
        phoneNumber: _activeNumber,
        startedAtEpochMs: started.millisecondsSinceEpoch,
        durationMs: ended.difference(started).inMilliseconds,
        filePath: file.path,
        note: '',
        status: SupportStatus.newTicket,
        recorderSource: _activeSource,
      ),
    );
    _activeStart = null;
    _activeNumber = 'unknown';
    _activeFile = null;
    _activeSource = 'unknown';
    _emitRecordingState();
  }

  void _emitRecordingState() {
    _recordingStateController.add(currentRecordingState);
  }
}

class ActiveRecordingState {
  const ActiveRecordingState({
    required this.isRecording,
    required this.phoneNumber,
    required this.startedAt,
  });

  final bool isRecording;
  final String phoneNumber;
  final DateTime? startedAt;
}
