package com.reco.support.domain.model

data class CallRecording(
    val id: Long,
    val phoneNumber: String,
    val startedAtEpochMs: Long,
    val durationMs: Long,
    val filePath: String,
    val note: String,
    val status: SupportStatus
)

enum class SupportStatus {
    NEW,
    IN_REVIEW,
    RESOLVED
}
