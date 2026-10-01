import 'package:sqflite/sqflite.dart';

import '../../data/models/task_model.dart';
import '../../database/database_helper.dart';
import '../../database/database_tables.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertTask(TaskModel task) async {
    final Database db = await _databaseHelper.database;

    return db.insert(
      DatabaseTables.tasks,
      task.toMap(),
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.tasks,
      orderBy: 'date ASC',
    );

    return result.map(TaskModel.fromMap).toList();
  }

  Future<int> updateTask(TaskModel task) async {
    final Database db = await _databaseHelper.database;

    return db.update(
      DatabaseTables.tasks,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final Database db = await _databaseHelper.database;

    return db.delete(
      DatabaseTables.tasks,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}