import 'package:sqflite/sqflite.dart';

import '../../database/database_helper.dart';
import '../../database/database_tables.dart';
import '../models/finance_transaction_model.dart';

class FinanceRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<int> insertTransaction(
    FinanceTransactionModel transaction,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.insert(
      DatabaseTables.financeTransactions,
      transaction.toMap(),
    );
  }

  Future<List<FinanceTransactionModel>>
      getTransactions() async {
    final Database db =
        await _databaseHelper.database;

    final result = await db.query(
      DatabaseTables.financeTransactions,
      orderBy: 'transaction_date DESC',
    );

    return result
        .map(
          FinanceTransactionModel.fromMap,
        )
        .toList();
  }

  Future<List<FinanceTransactionModel>>
      getMonthlyTransactions(
    int year,
    int month,
  ) async {
    final Database db =
        await _databaseHelper.database;

    final startDate =
        DateTime(year, month, 1);

    final endDate = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);

    final result = await db.query(
      DatabaseTables.financeTransactions,
      where:
          'transaction_date >= ? AND transaction_date < ?',
      whereArgs: [
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ],
    );

    return result
        .map(
          FinanceTransactionModel.fromMap,
        )
        .toList();
  }

  Future<int> updateTransaction(
    FinanceTransactionModel transaction,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.update(
      DatabaseTables.financeTransactions,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(
    int id,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return db.delete(
      DatabaseTables.financeTransactions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}