import 'package:flutter/material.dart';

import '../core/enums/transaction_type.dart';
import '../data/models/finance_transaction_model.dart';
import '../data/repositories/finance_repository.dart';

class FinanceProvider extends ChangeNotifier {
  final FinanceRepository _repository =
      FinanceRepository();

  List<FinanceTransactionModel>
      _transactions = [];

  bool _isLoading = false;

  List<FinanceTransactionModel>
      get transactions =>
          _transactions;

  bool get isLoading =>
      _isLoading;

  double get totalIncome {
    return _transactions
        .where(
          (e) =>
              e.type ==
              TransactionType.income,
        )
        .fold(
          0,
          (sum, item) =>
              sum + item.amount,
        );
  }

  double get totalExpense {
    return _transactions
        .where(
          (e) =>
              e.type ==
              TransactionType.expense,
        )
        .fold(
          0,
          (sum, item) =>
              sum + item.amount,
        );
  }

  double get totalSaving {
    return _transactions
        .where(
          (e) =>
              e.type ==
              TransactionType.saving,
        )
        .fold(
          0,
          (sum, item) =>
              sum + item.amount,
        );
  }

  double get balance {
    return totalIncome -
        totalExpense -
        totalSaving;
  }
  Future<void>
      loadTransactions() async {
    _isLoading = true;

    notifyListeners();

    _transactions =
        await _repository
            .getTransactions();

    _isLoading = false;

    notifyListeners();
  }

  Future<void> addTransaction(
    FinanceTransactionModel
        transaction,
  ) async {
    await _repository
        .insertTransaction(
      transaction,
    );

    await loadTransactions();
  }

  Future<void> updateTransaction(
    FinanceTransactionModel
        transaction,
  ) async {
    await _repository
        .updateTransaction(
      transaction,
    );

    await loadTransactions();
  }

  Future<void> deleteTransaction(
    int id,
  ) async {
    await _repository
        .deleteTransaction(id);

    await loadTransactions();
  }
  double get todayIncome {
  final now = DateTime.now();

  return _transactions
      .where(
        (e) =>
            e.type ==
                TransactionType.income &&
            e.transactionDate.year ==
                now.year &&
            e.transactionDate.month ==
                now.month &&
            e.transactionDate.day ==
                now.day,
      )
      .fold(
        0,
        (sum, item) =>
            sum + item.amount,
      );
}

double get todayExpense {
  final now = DateTime.now();

  return _transactions
      .where(
        (e) =>
            e.type ==
                TransactionType.expense &&
            e.transactionDate.year ==
                now.year &&
            e.transactionDate.month ==
                now.month &&
            e.transactionDate.day ==
                now.day,
      )
      .fold(
        0,
        (sum, item) =>
            sum + item.amount,
      );
      
}


}