package com.reco.support.data.recorder

import android.content.Context
import java.io.File

interface RecorderStrategy {
    val name: String
    fun start(context: Context, targetFile: File)
    fun stop()
}

class AudioRecorderEngine(
    private val strategies: List<RecorderStrategy>
) {
    private var activeStrategy: RecorderStrategy? = null
    private var activeFile: File? = null

    fun start(context: Context, targetFile: File): String {
        var lastError: Throwable? = null
        for (strategy in strategies) {
            try {
                strategy.start(context, targetFile)
                activeStrategy = strategy
                activeFile = targetFile
                return strategy.name
            } catch (error: Throwable) {
                lastError = error
            }
        }
        throw IllegalStateException("No recorder strategy succeeded", lastError)
    }

    fun stop(): File? {
        activeStrategy?.stop()
        val output = activeFile
        activeStrategy = null
        activeFile = null
        return output
    }
}
