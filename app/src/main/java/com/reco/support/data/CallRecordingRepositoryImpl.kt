package com.reco.support.data

import com.reco.support.data.local.CallRecordingDao
import com.reco.support.domain.model.CallRecording
import com.reco.support.domain.model.SupportStatus
import com.reco.support.domain.repository.CallRecordingRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class CallRecordingRepositoryImpl(
    private val dao: CallRecordingDao
) : CallRecordingRepository {
    override fun observeAll(): Flow<List<CallRecording>> = dao.observeAll().map { list ->
        list.map { it.toDomain() }
    }

    override suspend fun getById(id: Long): CallRecording? = dao.getById(id)?.toDomain()

    override suspend fun insert(recording: CallRecording): Long = dao.insert(recording.toEntity())

    override suspend fun updateNote(id: Long, note: String) = dao.updateNote(id, note)

    override suspend fun updateStatus(id: Long, status: SupportStatus) = dao.updateStatus(id, status.name)
}
