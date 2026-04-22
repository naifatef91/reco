import 'package:flutter/services.dart';

class NativeCallBridge {
  static const MethodChannel _channel =
      MethodChannel('com.reco.support/native_call_bridge');

  Future<void> startForegroundCallService() async {
    await _channel.invokeMethod<bool>('startForegroundCallService');
  }

  Future<void> stopForegroundCallService() async {
    await _channel.invokeMethod<bool>('stopForegroundCallService');
  }
}
