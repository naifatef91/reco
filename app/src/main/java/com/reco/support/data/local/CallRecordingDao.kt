package com.reco.support.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import kotlinx.coroutines.flow.Flow

@Dao
interface CallRecordingDao {
    @Query("SELECT * FROM call_recordings ORDER BY startedAtEpochMs DESC")
    fun observeAll(): Flow<List<CallRecordingEntity>>

    @Query("SELECT * FROM call_recordings WHERE id = :id")
    suspend fun getById(id: Long): CallRecordingEntity?

    @Insert
    suspend fun insert(entity: CallRecordingEntity): Long

    @Query("UPDATE call_recordings SET note = :note WHERE id = :id")
    suspend fun updateNote(id: Long, note: String)

    @Query("UPDATE call_recordings SET status = :status WHERE id = :id")
    suspend fun updateStatus(id: Long, status: String)
}
