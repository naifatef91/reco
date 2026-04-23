package com.reco.support

import android.Manifest
import android.app.PendingIntent
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.IBinder
import androidx.core.content.ContextCompat

class NativeCallForegroundService : Service() {
    companion object {
        const val ACTION_START = "com.reco.support.action.START_FOREGROUND"
        const val ACTION_STOP = "com.reco.support.action.STOP_FOREGROUND"
        private const val CHANNEL_ID = "support_call_monitor_channel"
        private const val NOTIFICATION_ID = 1001
        private const val EXTRA_STOP_RECORDING_REQUESTED = "stop_recording_requested"

        fun start(context: Context): Boolean {
            if (!hasRequiredPermissions(context)) return false
            val serviceIntent = Intent(context, NativeCallForegroundService::class.java).apply {
                action = ACTION_START
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
            return true
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, NativeCallForegroundService::class.java))
        }

        private fun hasRequiredPermissions(context: Context): Boolean {
            val hasAudioPermission = ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.RECORD_AUDIO
            ) == PackageManager.PERMISSION_GRANTED
            if (!hasAudioPermission) return false

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                val hasMicForegroundPermission = ContextCompat.checkSelfPermission(
                    context,
                    Manifest.permission.FOREGROUND_SERVICE_MICROPHONE
                ) == PackageManager.PERMISSION_GRANTED
                if (!hasMicForegroundPermission) return false
            }

            return true
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> stopSelf()
            else -> {
                if (!hasRequiredPermissions(this)) {
                    stopSelf()
                    return START_NOT_STICKY
                }
                try {
                    startForeground(NOTIFICATION_ID, buildNotification())
                } catch (_: SecurityException) {
                    stopSelf()
                    return START_NOT_STICKY
                } catch (_: IllegalStateException) {
                    stopSelf()
                    return START_NOT_STICKY
                }
            }
        }
        return START_STICKY
    }

    override fun onDestroy() {
        stopForeground(STOP_FOREGROUND_REMOVE)
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun buildNotification(): Notification {
        val manager = getSystemService(NotificationManager::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            manager.createNotificationChannel(
                NotificationChannel(
                    CHANNEL_ID,
                    "Support Call Monitor",
                    NotificationManager.IMPORTANCE_LOW
                )
            )
        }

        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, CHANNEL_ID)
        } else {
            Notification.Builder(this)
        }

        val openAppIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra(EXTRA_STOP_RECORDING_REQUESTED, true)
        }
        val openAppPendingIntent = PendingIntent.getActivity(
            this,
            1101,
            openAppIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        return builder
            .setContentTitle("Support Call Recorder")
            .setContentText("Call monitoring is active. Tap stop action to end recording.")
            .setSmallIcon(android.R.drawable.ic_btn_speak_now)
            .setContentIntent(openAppPendingIntent)
            .addAction(
                Notification.Action.Builder(
                    0,
                    "Stop Recording",
                    openAppPendingIntent
                ).build()
            )
            .setOngoing(true)
            .build()
    }
}
