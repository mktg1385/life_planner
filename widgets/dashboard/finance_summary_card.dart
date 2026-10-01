import 'package:flutter/material.dart';
import '../../core/utils/money_formatter.dart';

class FinanceSummaryCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expense;

  const FinanceSummaryCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: theme.brightness == Brightness.light
            ? const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'وضعیت مالی',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            MoneyFormatter.format(balance),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'درآمد',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        MoneyFormatter.format(income),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'هزینه',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        MoneyFormatter.format(expense),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}