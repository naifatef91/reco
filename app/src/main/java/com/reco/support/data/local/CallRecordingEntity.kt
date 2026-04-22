package com.reco.support.data.local

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "call_recordings")
data class CallRecordingEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val phoneNumber: String,
    val startedAtEpochMs: Long,
    val durationMs: Long,
    val filePath: String,
    val note: String,
    val status: String
)
