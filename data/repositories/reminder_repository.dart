import 'package:sqflite/sqflite.dart';

import '../../data/models/reminder_model.dart';
import '../../database/database_helper.dart';
import '../../database/database_tables.dart';

class ReminderRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertReminder(ReminderModel reminder) async {
    final Database db = await _databaseHelper.database;

    return db.insert(
      DatabaseTables.reminders,
      reminder.toMap(),
    );
  }

  Future<List<ReminderModel>> getReminders() async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.reminders,
      orderBy: 'reminder_date_time ASC',
    );

    return result.map(ReminderModel.fromMap).toList();
  }

  Future<int> updateReminder(ReminderModel reminder) async {
    final Database db = await _databaseHelper.database;

    return db.update(
      DatabaseTables.reminders,
      reminder.toMap(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<int> deleteReminder(int id) async {
    final Database db = await _databaseHelper.database;

    return db.delete(
      DatabaseTables.reminders,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}