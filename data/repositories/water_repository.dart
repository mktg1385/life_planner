import 'package:sqflite/sqflite.dart';

import '../../data/models/water_model.dart';
import '../../database/database_helper.dart';
import '../../database/database_tables.dart';

class WaterRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertWater(WaterModel water) async {
    final Database db = await _databaseHelper.database;

    return db.insert(
      DatabaseTables.waterLogs,
      water.toMap(),
    );
  }

  Future<List<WaterModel>> getAllWaterLogs() async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.waterLogs,
      orderBy: 'created_at DESC',
    );

    return result.map(WaterModel.fromMap).toList();
  }

  Future<WaterModel?> getTodayWaterLog() async {
    final Database db = await _databaseHelper.database;

    final now = DateTime.now();

    final startOfDay = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final result = await db.query(
      DatabaseTables.waterLogs,
      where: 'created_at >= ?',
      whereArgs: [startOfDay.toIso8601String()],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return WaterModel.fromMap(result.first);
  }

  Future<int> updateWater(WaterModel water) async {
    final Database db = await _databaseHelper.database;

    return db.update(
      DatabaseTables.waterLogs,
      water.toMap(),
      where: 'id = ?',
      whereArgs: [water.id],
    );
  }

  Future<int> deleteWater(int id) async {
    final Database db = await _databaseHelper.database;

    return db.delete(
      DatabaseTables.waterLogs,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}