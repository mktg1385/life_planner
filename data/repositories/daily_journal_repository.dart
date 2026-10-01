import '../../database/database_helper.dart';
import '../../database/database_tables.dart';
import '../models/daily_journal_model.dart';

class DailyJournalRepository {
  final DatabaseHelper _db =
      DatabaseHelper.instance;

  Future<int> insert(
    DailyJournalModel journal,
  ) async {
    final database =
        await _db.database;

    return database.insert(
      DatabaseTables.dailyJournal,
      journal.toMap(),
    );
  }

  Future<void> update(
    DailyJournalModel journal,
  ) async {
    final database =
        await _db.database;

    await database.update(
      DatabaseTables.dailyJournal,
      journal.toMap(),
      where: 'id = ?',
      whereArgs: [journal.id],
    );
  }

Future<DailyJournalModel?> getByDate(
  DateTime date,
) async {
  final database =
      await _db.database;

  final dayString =
      DateTime(
        date.year,
        date.month,
        date.day,
      ).toIso8601String();

  final result = await database.query(
    DatabaseTables.dailyJournal,
    where: 'date = ?',
    whereArgs: [dayString],
    limit: 1,
  );

  if (result.isEmpty) {
    return null;
  }

  return DailyJournalModel.fromMap(
    result.first,
  );
}

  Future<List<DailyJournalModel>>
      getAll() async {
    final database =
        await _db.database;

    final result = await database.query(
      DatabaseTables.dailyJournal,
      orderBy: 'date DESC',
    );

    return result
        .map(
          (e) =>
              DailyJournalModel.fromMap(
            e,
          ),
        )
        .toList();
  }

  Future<void> delete(
    int id,
  ) async {
    final database =
        await _db.database;

    await database.delete(
      DatabaseTables.dailyJournal,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}