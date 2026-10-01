import '../core/enums/transaction_type.dart';
import '../data/models/finance_transaction_model.dart';

class FinanceStatisticsService {
  FinanceStatisticsService._();

  static double totalIncome(
    List<FinanceTransactionModel> items,
  ) {
    return items
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

  static double totalExpense(
    List<FinanceTransactionModel> items,
  ) {
    return items
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

  static double totalSaving(
    List<FinanceTransactionModel> items,
  ) {
    return items
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

  static double balance(
    List<FinanceTransactionModel> items,
  ) {
    return totalIncome(items) -
        totalExpense(items);
  }
}