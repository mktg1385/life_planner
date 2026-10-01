import '../../core/enums/transaction_type.dart';

class FinanceTransactionModel {
  final int? id;
  final String title;
  final double amount;
  final TransactionType type;
  final String? description;
  final DateTime transactionDate;
  final DateTime createdAt;

  const FinanceTransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    this.description,
    required this.transactionDate,
    required this.createdAt,
  });

  FinanceTransactionModel copyWith({
    int? id,
    String? title,
    double? amount,
    TransactionType? type,
    String? description,
    DateTime? transactionDate,
    DateTime? createdAt,
  }) {
    return FinanceTransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.name,
      'description': description,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FinanceTransactionModel.fromMap(Map<String, dynamic> map) {
    return FinanceTransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
      ),
      description: map['description'] as String?,
      transactionDate: DateTime.parse(map['transaction_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}