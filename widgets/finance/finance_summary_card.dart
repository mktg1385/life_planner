import 'package:flutter/material.dart';

class FinanceSummaryCard
    extends StatelessWidget {
  final double income;
  final double expense;
  final double saving;

  const FinanceSummaryCard({
    super.key,
    required this.income,
    required this.expense,
    required this.saving,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(28),
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
        ),
      ),
      child: Column(
        children: [
          _FinanceItem(
            title: 'درآمد',
            value: income,
            icon: Icons.trending_up,
          ),
          const SizedBox(height: 16),
          _FinanceItem(
            title: 'هزینه',
            value: expense,
            icon:
                Icons.trending_down,
          ),
          const SizedBox(height: 16),
          _FinanceItem(
            title: 'پس‌انداز',
            value: saving,
            icon: Icons.savings,
          ),
        ],
      ),
    );
  }
}

class _FinanceItem
    extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;

  const _FinanceItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style:
                const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Text(
          value.toStringAsFixed(0),
          style:
              const TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}