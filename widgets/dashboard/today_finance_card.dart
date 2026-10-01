import 'package:flutter/material.dart';
import '../../core/utils/money_formatter.dart';

class TodayFinanceCard extends StatelessWidget {
  final double income;
  final double expense;

  final VoidCallback onAddTransaction;
  final VoidCallback onOpenFinance;

  const TodayFinanceCard({
    super.key,
    required this.income,
    required this.expense,
    required this.onAddTransaction,
    required this.onOpenFinance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: isDark
            ? []
            : const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: colorScheme.primary,
              ),

              const SizedBox(width: 8),

              Text(
                'مالی امروز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: onOpenFinance,
                child: const Text('جزئیات'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'درآمد',
                        style: theme.textTheme.bodySmall,
                      ),

                      const SizedBox(height: 6),

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
                    color: Colors.red.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'هزینه',
                        style: theme.textTheme.bodySmall,
                      ),

                      const SizedBox(height: 6),

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

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onAddTransaction,
              icon: const Icon(Icons.add),
              label: const Text('ثبت تراکنش'),
            ),
          ),
        ],
      ),
    );
  }
}