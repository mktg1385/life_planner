import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../services/database_migration_service.dart';
import 'database_tables.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, 'life_planner.db');

    return openDatabase(
      path,
      version: 7,
      onCreate: _onCreate,
      onUpgrade: DatabaseMigrationService.onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseTables.tasks}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        is_completed INTEGER NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.reminders}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        reminder_date_time TEXT NOT NULL,
        repeat_type TEXT NOT NULL,
        is_active INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.financeTransactions}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        description TEXT,
        transaction_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.moods}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mood INTEGER NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.waterLogs}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        glasses_count INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.sleepTracking}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sleep_time TEXT NOT NULL,
        wake_time TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.shoppingItems}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        is_completed INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.contacts}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        is_favorite INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.gratitudeNotes}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.challenges}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        progress INTEGER NOT NULL,
        completed INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.calendarEvents}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        is_holiday INTEGER NOT NULL,
        is_official_event INTEGER NOT NULL
      )
    ''');

    await db.execute('''
CREATE TABLE ${DatabaseTables.dailyJournal}(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL UNIQUE,
  mood INTEGER,
  mood_note TEXT,
  water_count INTEGER,
  sleep_hours REAL,
  created_at TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE ${DatabaseTables.userSettings}(
  id INTEGER PRIMARY KEY,
  suggestion_time TEXT NOT NULL,
  smart_notification_enabled INTEGER NOT NULL
)
''');
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
