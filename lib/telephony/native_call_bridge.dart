import 'package:flutter/services.dart';

class NativeCallBridge {
  static const MethodChannel _channel =
      MethodChannel('com.reco.support/native_call_bridge');

  Future<bool> startForegroundCallService() async {
    final result = await _channel.invokeMethod<bool>('startForegroundCallService');
    return result ?? false;
  }

  Future<void> stopForegroundCallService() async {
    await _channel.invokeMethod<bool>('stopForegroundCallService');
  }

  Future<void> updateForegroundRecordingState({
    required bool isRecording,
    required String phoneNumber,
  }) async {
    await _channel.invokeMethod<bool>(
      'updateForegroundRecordingState',
      <String, dynamic>{
        'isRecording': isRecording,
        'phoneNumber': phoneNumber,
      },
    );
  }

  Future<bool> consumePendingStopRecordingRequest() async {
    final result =
        await _channel.invokeMethod<bool>('consumePendingStopRecordingRequest');
    return result ?? false;
  }
}
