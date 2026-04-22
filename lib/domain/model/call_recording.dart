import 'package:support_call_recorder/domain/model/support_status.dart';

class CallRecording {
  const CallRecording({
    required this.id,
    required this.phoneNumber,
    required this.startedAtEpochMs,
    required this.durationMs,
    required this.filePath,
    required this.note,
    required this.status,
    required this.recorderSource,
  });

  final int? id;
  final String phoneNumber;
  final int startedAtEpochMs;
  final int durationMs;
  final String filePath;
  final String note;
  final SupportStatus status;
  final String recorderSource;

  CallRecording copyWith({
    int? id,
    String? phoneNumber,
    int? startedAtEpochMs,
    int? durationMs,
    String? filePath,
    String? note,
    SupportStatus? status,
    String? recorderSource,
  }) {
    return CallRecording(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      startedAtEpochMs: startedAtEpochMs ?? this.startedAtEpochMs,
      durationMs: durationMs ?? this.durationMs,
      filePath: filePath ?? this.filePath,
      note: note ?? this.note,
      status: status ?? this.status,
      recorderSource: recorderSource ?? this.recorderSource,
    );
  }
}
