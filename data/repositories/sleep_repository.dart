import '../../database/database_helper.dart';
import '../../database/database_tables.dart';
import '../models/sleep_model.dart';

class SleepRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<int> insertSleepRecord(
    SleepModel sleep,
  ) async {
    final db =
        await _databaseHelper.database;

    return db.insert(
      DatabaseTables.sleepTracking,
      sleep.toMap(),
    );
  }

  Future<List<SleepModel>>
      getSleepRecords() async {
    final db =
        await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.sleepTracking,
      orderBy: 'created_at DESC',
    );

    return result
        .map(
          (e) => SleepModel.fromMap(e),
        )
        .toList();
  }

  Future<SleepModel?>
      getLatestSleepRecord() async {
    final db =
        await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.sleepTracking,
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return SleepModel.fromMap(
      result.first,
    );
  }

  Future<int> updateSleepRecord(
    SleepModel sleep,
  ) async {
    final db =
        await _databaseHelper.database;

    return db.update(
      DatabaseTables.sleepTracking,
      sleep.toMap(),
      where: 'id = ?',
      whereArgs: [sleep.id],
    );
  }

  Future<int> deleteSleepRecord(
    int id,
  ) async {
    final db =
        await _databaseHelper.database;

    return db.delete(
      DatabaseTables.sleepTracking,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}