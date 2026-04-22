package com.reco.support.data.local

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(
    entities = [CallRecordingEntity::class],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun callRecordingDao(): CallRecordingDao
}
