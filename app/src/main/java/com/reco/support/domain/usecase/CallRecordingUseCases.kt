package com.reco.support.domain.usecase

import com.reco.support.domain.model.CallRecording
import com.reco.support.domain.model.SupportStatus
import com.reco.support.domain.repository.CallRecordingRepository
import kotlinx.coroutines.flow.Flow

class ObserveRecordingsUseCase(private val repository: CallRecordingRepository) {
    operator fun invoke(): Flow<List<CallRecording>> = repository.observeAll()
}

class GetRecordingUseCase(private val repository: CallRecordingRepository) {
    suspend operator fun invoke(id: Long): CallRecording? = repository.getById(id)
}

class SaveRecordingUseCase(private val repository: CallRecordingRepository) {
    suspend operator fun invoke(recording: CallRecording): Long = repository.insert(recording)
}

class UpdateRecordingNoteUseCase(private val repository: CallRecordingRepository) {
    suspend operator fun invoke(id: Long, note: String) = repository.updateNote(id, note)
}

class UpdateRecordingStatusUseCase(private val repository: CallRecordingRepository) {
    suspend operator fun invoke(id: Long, status: SupportStatus) = repository.updateStatus(id, status)
}
