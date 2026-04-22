package com.reco.support.data

import com.reco.support.data.local.CallRecordingEntity
import com.reco.support.domain.model.CallRecording
import com.reco.support.domain.model.SupportStatus

fun CallRecordingEntity.toDomain(): CallRecording = CallRecording(
    id = id,
    phoneNumber = phoneNumber,
    startedAtEpochMs = startedAtEpochMs,
    durationMs = durationMs,
    filePath = filePath,
    note = note,
    status = runCatching { SupportStatus.valueOf(status) }.getOrDefault(SupportStatus.NEW)
)

fun CallRecording.toEntity(): CallRecordingEntity = CallRecordingEntity(
    id = id,
    phoneNumber = phoneNumber,
    startedAtEpochMs = startedAtEpochMs,
    durationMs = durationMs,
    filePath = filePath,
    note = note,
    status = status.name
)
