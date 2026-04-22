package com.reco.support

import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "com.reco.support/native_call_bridge"
private const val ACTION_START = "startForegroundCallService"
private const val ACTION_STOP = "stopForegroundCallService"

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    ACTION_START -> {
                        val started = NativeCallForegroundService.start(this)
                        result.success(started)
                    }

                    ACTION_STOP -> {
                        NativeCallForegroundService.stop(this)
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
