import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_transaction_page.dart';
import '../../../providers/finance_provider.dart';
import '../../../widgets/finance/finance_chart_card.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../widgets/dashboard/finance_summary_card.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({
    super.key,
  });

  @override
  State<FinancePage> createState() =>
      _FinancePageState();
}

class _FinancePageState
    extends State<FinancePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<FinanceProvider>()
          .loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<FinanceProvider>();

    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddTransactionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(
        title: const Text(
          'مدیریت مالی',
        ),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          FinanceSummaryCard(
            balance: provider.balance,
            income: provider.totalIncome,
            expense: provider.totalExpense,
          ),

          const SizedBox(height: 20),

          FinanceChartCard(
            chartData: [
              FinanceChartData(
                title: 'درآمد',
                value:
                    provider.totalIncome,
              ),
              FinanceChartData(
                title: 'هزینه',
                value:
                    provider.totalExpense,
              ),
              FinanceChartData(
                title: 'پس‌انداز',
                value:
                    provider.totalSaving,
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (provider.transactions.isEmpty)
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                        32),
                child: Text(
                  'هنوز تراکنشی ثبت نشده است.',
                  style: TextStyle(
                    color: theme
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ),
            ),

          ...provider.transactions.map(
            (transaction) {
              final isIncome =
                  transaction.type.name ==
                      'income';

              return Card(
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                elevation: 0,
                color: theme
                    .colorScheme.surface,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isIncome
                            ? Colors.green
                                .withOpacity(
                                    .12)
                            : Colors.red
                                .withOpacity(
                                    .12),
                    child: Icon(
                      isIncome
                          ? Icons
                              .south_west_rounded
                          : Icons
                              .north_east_rounded,
                      color: isIncome
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  title: Text(
                    transaction.title,
                    style: TextStyle(
                      color: theme
                          .colorScheme
                          .onSurface,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    transaction.type.name ==
                            'income'
                        ? 'درآمد'
                        : transaction.type
                                    .name ==
                                'saving'
                            ? 'پس‌انداز'
                            : 'هزینه',
                    style: TextStyle(
                      color: theme
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),

                  trailing: Text(
                    MoneyFormatter.format(
                      transaction.amount,
                    ),
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      color: isIncome
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}