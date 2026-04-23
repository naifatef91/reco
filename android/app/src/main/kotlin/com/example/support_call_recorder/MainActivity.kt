package com.reco.support

import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "com.reco.support/native_call_bridge"
private const val ACTION_START = "startForegroundCallService"
private const val ACTION_STOP = "stopForegroundCallService"
private const val ACTION_CONSUME_STOP_REQUEST = "consumePendingStopRecordingRequest"
private const val ACTION_UPDATE_RECORDING_STATE = "updateForegroundRecordingState"
private const val EXTRA_STOP_RECORDING_REQUESTED = "stop_recording_requested"

class MainActivity : FlutterFragmentActivity() {
    companion object {
        @Volatile
        private var pendingStopRecordingRequest = false
    }

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

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

                    ACTION_CONSUME_STOP_REQUEST -> {
                        val shouldStop = pendingStopRecordingRequest
                        pendingStopRecordingRequest = false
                        result.success(shouldStop)
                    }

                    ACTION_UPDATE_RECORDING_STATE -> {
                        val isRecording = call.argument<Boolean>("isRecording") ?: false
                        val phoneNumber = call.argument<String>("phoneNumber") ?: ""
                        NativeCallForegroundService.updateRecordingState(
                            applicationContext,
                            isRecording,
                            phoneNumber
                        )
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun handleIntent(intent: Intent?) {
        if (intent?.getBooleanExtra(EXTRA_STOP_RECORDING_REQUESTED, false) == true) {
            pendingStopRecordingRequest = true
        }
    }
}
