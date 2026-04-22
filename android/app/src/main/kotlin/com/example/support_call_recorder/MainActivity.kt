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
                        startService(Intent(this, NativeCallForegroundService::class.java).apply {
                            action = NativeCallForegroundService.ACTION_START
                        })
                        result.success(true)
                    }

                    ACTION_STOP -> {
                        startService(Intent(this, NativeCallForegroundService::class.java).apply {
                            action = NativeCallForegroundService.ACTION_STOP
                        })
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
