import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> database() async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'support_call_recorder.db');
    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE call_recordings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phoneNumber TEXT NOT NULL,
            startedAtEpochMs INTEGER NOT NULL,
            durationMs INTEGER NOT NULL,
            filePath TEXT NOT NULL,
            note TEXT NOT NULL,
            status TEXT NOT NULL,
            recorderSource TEXT NOT NULL
          )
        ''');
      },
    );
    return _db!;
  }
}
