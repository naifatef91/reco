import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';
import 'package:support_call_recorder/domain/repository/call_recording_repository.dart';

class CallRecordingUseCases {
  const CallRecordingUseCases(this._repository);
  final CallRecordingRepository _repository;

  Future<List<CallRecording>> list() => _repository.getAll();
  Future<CallRecording?> byId(int id) => _repository.getById(id);
  Future<int> save(CallRecording recording) => _repository.insert(recording);
  Future<void> updateNote(int id, String note) =>
      _repository.updateNote(id, note);
  Future<void> updateStatus(int id, SupportStatus status) =>
      _repository.updateStatus(id, status);
}
