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

class CallMonitorService {
  CallMonitorService({
    required CallRecordingUseCases useCases,
    required AudioRecorderEngine engine,
    required FileCrypto fileCrypto,
    required PermissionService permissionService,
    required NativeCallBridge nativeBridge,
  })  : _useCases = useCases,
        _engine = engine,
        _fileCrypto = fileCrypto,
        _permissionService = permissionService,
        _nativeBridge = nativeBridge;

  final CallRecordingUseCases _useCases;
  final AudioRecorderEngine _engine;
  final FileCrypto _fileCrypto;
  final PermissionService _permissionService;
  final NativeCallBridge _nativeBridge;

  StreamSubscription<PhoneState>? _subscription;
  DateTime? _activeStart;
  String _activeNumber = 'unknown';
  File? _activeFile;
  String _activeSource = 'unknown';

  Future<void> start() async {
    final allowed = await _permissionService.ensureRequired();
    if (!allowed) return;
    await _nativeBridge.startForegroundCallService();

    _subscription ??= PhoneState.stream.listen((event) async {
      if (event.status == PhoneStateStatus.CALL_STARTED) {
        await _onCallStarted(event.number ?? 'unknown');
      }
      if (event.status == PhoneStateStatus.CALL_ENDED) {
        await _onCallEnded();
      }
    });
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    await _nativeBridge.stopForegroundCallService();
  }

  Future<void> _onCallStarted(String number) async {
    if (_activeStart != null) return;
    final dir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = p.join(dir.path, 'calls', 'call_$timestamp.m4a');
    final file = File(path);
    await file.parent.create(recursive: true);
    _activeSource = await _engine.start(file);
    _activeStart = DateTime.now();
    _activeNumber = number;
    _activeFile = file;
  }

  Future<void> _onCallEnded() async {
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
  }
}
