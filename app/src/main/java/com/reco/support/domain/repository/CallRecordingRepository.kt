package com.reco.support.domain.repository

import com.reco.support.domain.model.CallRecording
import com.reco.support.domain.model.SupportStatus
import kotlinx.coroutines.flow.Flow

interface CallRecordingRepository {
    fun observeAll(): Flow<List<CallRecording>>
    suspend fun getById(id: Long): CallRecording?
    suspend fun insert(recording: CallRecording): Long
    suspend fun updateNote(id: Long, note: String)
    suspend fun updateStatus(id: Long, status: SupportStatus)
}
