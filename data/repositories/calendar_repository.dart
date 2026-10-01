import 'package:sqflite/sqflite.dart';

import '../../database/database_helper.dart';
import '../../database/database_tables.dart';
import '../models/calendar_event_model.dart';

class CalendarRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<List<CalendarEventModel>>
      getEvents() async {
    final Database db =
        await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.calendarEvents,
      orderBy: 'date ASC',
    );

    return result
        .map(
          (e) =>
              CalendarEventModel.fromMap(
            e,
          ),
        )
        .toList();
  }

  Future<int> insertEvent(
    CalendarEventModel event,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.insert(
      DatabaseTables.calendarEvents,
      event.toMap(),
    );
  }

  Future<int> updateEvent(
    CalendarEventModel event,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.update(
      DatabaseTables.calendarEvents,
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(
    int id,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.delete(
      DatabaseTables.calendarEvents,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}