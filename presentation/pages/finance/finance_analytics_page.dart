import 'package:flutter/material.dart';

import '../../../widgets/finance/finance_pie_chart.dart';

class FinanceAnalyticsPage
    extends StatelessWidget {
  const FinanceAnalyticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(
        0xFFF5F6FA,
      ),
      appBar: AppBar(
        title: const Text(
          'گزارش مالی',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: FinancePieChart(
          items: const [
            FinancePieItem(
              category: 'درآمد',
              value: 12000000,
            ),
            FinancePieItem(
              category: 'هزینه',
              value: 4500000,
            ),
            FinancePieItem(
              category: 'پس‌انداز',
              value: 7500000,
            ),
          ],
        ),
      ),
    );
  }
}