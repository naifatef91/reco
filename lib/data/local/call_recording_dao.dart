import 'package:support_call_recorder/data/local/database.dart';
import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';

class CallRecordingDao {
  Future<List<CallRecording>> list() async {
    final db = await AppDatabase.instance.database();
    final rows =
        await db.query('call_recordings', orderBy: 'startedAtEpochMs DESC');
    return rows.map(_toModel).toList();
  }

  Future<CallRecording?> byId(int id) async {
    final db = await AppDatabase.instance.database();
    final rows = await db.query('call_recordings',
        where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return _toModel(rows.first);
  }

  Future<int> insert(CallRecording recording) async {
    final db = await AppDatabase.instance.database();
    return db.insert('call_recordings', {
      'phoneNumber': recording.phoneNumber,
      'startedAtEpochMs': recording.startedAtEpochMs,
      'durationMs': recording.durationMs,
      'filePath': recording.filePath,
      'note': recording.note,
      'status': recording.status.name,
      'recorderSource': recording.recorderSource,
    });
  }

  Future<void> updateNote(int id, String note) async {
    final db = await AppDatabase.instance.database();
    await db.update('call_recordings', {'note': note},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateStatus(int id, SupportStatus status) async {
    final db = await AppDatabase.instance.database();
    await db.update('call_recordings', {'status': status.name},
        where: 'id = ?', whereArgs: [id]);
  }

  CallRecording _toModel(Map<String, Object?> row) {
    final parsed = SupportStatus.values.firstWhere(
      (e) => e.name == row['status'],
      orElse: () => SupportStatus.newTicket,
    );
    return CallRecording(
      id: row['id'] as int,
      phoneNumber: row['phoneNumber'] as String,
      startedAtEpochMs: row['startedAtEpochMs'] as int,
      durationMs: row['durationMs'] as int,
      filePath: row['filePath'] as String,
      note: row['note'] as String,
      status: parsed,
      recorderSource: row['recorderSource'] as String,
    );
  }
}
