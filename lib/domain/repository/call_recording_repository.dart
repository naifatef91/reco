import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';

abstract class CallRecordingRepository {
  Future<List<CallRecording>> getAll();
  Future<CallRecording?> getById(int id);
  Future<int> insert(CallRecording recording);
  Future<void> updateNote(int id, String note);
  Future<void> updateStatus(int id, SupportStatus status);
}
