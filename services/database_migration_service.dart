import 'package:sqflite/sqflite.dart';

import '../database/database_tables.dart';

class DatabaseMigrationService {
  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await _migrationV2(db);
    }

    if (oldVersion < 3) {
      await _migrationV3(db);
    }

    if (oldVersion < 4) {
      await _migrationV4(db);
    }

    if (oldVersion < 5) {
      await _migrationV5(db);
    }
    if (oldVersion < 6) {
      await _migrationV6(db);
    }
    if (oldVersion < 7) {
      await _migrationV7(db);
    }
  }

  static Future<void> _migrationV2(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseTables.contacts}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        is_favorite INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _migrationV3(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseTables.gratitudeNotes}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _migrationV4(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseTables.challenges}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        progress INTEGER NOT NULL,
        completed INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _migrationV5(Database db) async {}
  static Future<void> _migrationV6(Database db) async {
    await db.execute('''
  CREATE TABLE IF NOT EXISTS ${DatabaseTables.dailyJournal}(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL UNIQUE,
    mood INTEGER,
    mood_note TEXT,
    water_count INTEGER,
    sleep_hours REAL,
    created_at TEXT NOT NULL
  )
  ''');
  }

  static Future<void> _migrationV7(Database db) async {
    await db.execute('''
  CREATE TABLE IF NOT EXISTS ${DatabaseTables.userSettings}(
    id INTEGER PRIMARY KEY,
    suggestion_time TEXT NOT NULL,
    smart_notification_enabled INTEGER NOT NULL
  )
  ''');

    await db.insert(DatabaseTables.userSettings, {
      'id': 1,
      'suggestion_time': '20:00',
      'smart_notification_enabled': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
