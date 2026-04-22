package com.reco.support.data.recorder

import android.content.Context
import android.media.MediaRecorder
import android.os.Build
import java.io.File

class MicRecorderStrategy : RecorderStrategy {
    private var recorder: MediaRecorder? = null
    override val name: String = "microphone_fallback"

    override fun start(context: Context, targetFile: File) {
        val mediaRecorder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            MediaRecorder(context)
        } else {
            @Suppress("DEPRECATION")
            MediaRecorder()
        }
        mediaRecorder.setAudioSource(MediaRecorder.AudioSource.MIC)
        mediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
        mediaRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
        mediaRecorder.setOutputFile(targetFile.absolutePath)
        mediaRecorder.prepare()
        mediaRecorder.start()
        recorder = mediaRecorder
    }

    override fun stop() {
        recorder?.runCatching {
            stop()
            release()
        }
        recorder = null
    }
}
