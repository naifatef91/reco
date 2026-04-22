package com.reco.support.data

import android.content.Context
import androidx.room.Room
import com.reco.support.data.local.AppDatabase
import com.reco.support.data.recorder.AudioRecorderEngine
import com.reco.support.data.recorder.MediaRecorderStrategy
import com.reco.support.data.recorder.MicRecorderStrategy
import com.reco.support.data.security.FileCryptoManager
import com.reco.support.domain.repository.CallRecordingRepository
import com.reco.support.domain.usecase.GetRecordingUseCase
import com.reco.support.domain.usecase.ObserveRecordingsUseCase
import com.reco.support.domain.usecase.SaveRecordingUseCase
import com.reco.support.domain.usecase.UpdateRecordingNoteUseCase
import com.reco.support.domain.usecase.UpdateRecordingStatusUseCase

class AppContainer(context: Context) {
    private val database = Room.databaseBuilder(
        context,
        AppDatabase::class.java,
        "support-recorder.db"
    ).build()

    val repository: CallRecordingRepository = CallRecordingRepositoryImpl(database.callRecordingDao())
    val recorderEngine = AudioRecorderEngine(
        strategies = listOf(MediaRecorderStrategy(), MicRecorderStrategy())
    )
    val cryptoManager = FileCryptoManager(context)

    val observeRecordingsUseCase = ObserveRecordingsUseCase(repository)
    val getRecordingUseCase = GetRecordingUseCase(repository)
    val saveRecordingUseCase = SaveRecordingUseCase(repository)
    val updateRecordingNoteUseCase = UpdateRecordingNoteUseCase(repository)
    val updateRecordingStatusUseCase = UpdateRecordingStatusUseCase(repository)
}
