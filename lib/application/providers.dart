import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:support_call_recorder/application/app_settings.dart';
import 'package:support_call_recorder/data/local/call_recording_dao.dart';
import 'package:support_call_recorder/data/local/app_settings_store.dart';
import 'package:support_call_recorder/data/recorder/audio_recorder_engine.dart';
import 'package:support_call_recorder/data/recorder/mic_recorder_strategy.dart';
import 'package:support_call_recorder/data/recorder/voice_call_recorder_strategy.dart';
import 'package:support_call_recorder/data/repository/call_recording_repository_impl.dart';
import 'package:support_call_recorder/data/security/biometric_auth_service.dart';
import 'package:support_call_recorder/data/security/file_crypto.dart';
import 'package:support_call_recorder/domain/repository/call_recording_repository.dart';
import 'package:support_call_recorder/domain/usecase/call_recording_usecases.dart';
import 'package:support_call_recorder/telephony/call_monitor_service.dart';
import 'package:support_call_recorder/telephony/native_call_bridge.dart';

final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService());

final recordingDaoProvider =
    Provider<CallRecordingDao>((ref) => CallRecordingDao());

final repositoryProvider = Provider<CallRecordingRepository>((ref) {
  return CallRecordingRepositoryImpl(ref.watch(recordingDaoProvider));
});

final useCasesProvider = Provider<CallRecordingUseCases>((ref) {
  return CallRecordingUseCases(ref.watch(repositoryProvider));
});

final audioEngineProvider = Provider<AudioRecorderEngine>((ref) {
  final recorder = AudioRecorder();
  return AudioRecorderEngine([
    VoiceCallRecorderStrategy(recorder),
    MicRecorderStrategy(recorder),
  ]);
});

final fileCryptoProvider =
    Provider<FileCrypto>((ref) => FileCrypto('support-recorder-device-seed'));
final nativeCallBridgeProvider =
    Provider<NativeCallBridge>((ref) => NativeCallBridge());
final appSettingsStoreProvider =
    Provider<AppSettingsStore>((ref) => AppSettingsStore());
final localAuthenticationProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());
final biometricAuthServiceProvider = Provider<BiometricAuthService>(
  (ref) => BiometricAuthService(ref.watch(localAuthenticationProvider)),
);

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettings>(
  (ref) => AppSettingsController(
    ref.watch(appSettingsStoreProvider),
  )..load(),
);

final callMonitorServiceProvider = Provider<CallMonitorService>((ref) {
  return CallMonitorService(
    useCases: ref.watch(useCasesProvider),
    engine: ref.watch(audioEngineProvider),
    fileCrypto: ref.watch(fileCryptoProvider),
    permissionService: ref.watch(permissionServiceProvider),
    nativeBridge: ref.watch(nativeCallBridgeProvider),
  );
});

class PermissionService {
  Future<PermissionRequestResult> requestRequired() async {
    final statuses = await <Permission>[
      Permission.microphone,
      Permission.phone,
      Permission.notification,
    ].request();

    final allGranted = statuses.values.every((status) => status.isGranted);
    final hasPermanentlyDenied =
        statuses.values.any((status) => status.isPermanentlyDenied);
    return PermissionRequestResult(
      allGranted: allGranted,
      hasPermanentlyDenied: hasPermanentlyDenied,
    );
  }

  Future<bool> ensureRequired() async {
    final result = await requestRequired();
    return result.allGranted;
  }
}

class PermissionRequestResult {
  const PermissionRequestResult({
    required this.allGranted,
    required this.hasPermanentlyDenied,
  });

  final bool allGranted;
  final bool hasPermanentlyDenied;
}

class AppSettingsController extends StateNotifier<AppSettings> {
  AppSettingsController(this._store) : super(AppSettings.initial);

  final AppSettingsStore _store;

  Future<void> load() async {
    state = await _store.read();
  }

  Future<void> setLanguageCode(String languageCode) async {
    await _store.saveLanguageCode(languageCode);
    state = state.copyWith(locale: Locale(languageCode));
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _store.saveBiometricEnabled(enabled);
    state = state.copyWith(biometricEnabled: enabled);
  }
}
