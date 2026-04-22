import 'package:support_call_recorder/data/local/call_recording_dao.dart';
import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';
import 'package:support_call_recorder/domain/repository/call_recording_repository.dart';

class CallRecordingRepositoryImpl implements CallRecordingRepository {
  CallRecordingRepositoryImpl(this._dao);
  final CallRecordingDao _dao;

  @override
  Future<List<CallRecording>> getAll() => _dao.list();

  @override
  Future<CallRecording?> getById(int id) => _dao.byId(id);

  @override
  Future<int> insert(CallRecording recording) => _dao.insert(recording);

  @override
  Future<void> updateNote(int id, String note) => _dao.updateNote(id, note);

  @override
  Future<void> updateStatus(int id, SupportStatus status) =>
      _dao.updateStatus(id, status);
}
