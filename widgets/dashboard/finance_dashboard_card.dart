import 'package:flutter/material.dart';
import '../../../core/utils/money_formatter.dart';
class FinanceDashboardCard extends StatelessWidget {
  final double income;
  final double expense;

  final VoidCallback onTap;

  const FinanceDashboardCard({
    super.key,
    required this.income,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.account_balance_wallet),
                SizedBox(width: 8),
                Text(
                  'وضعیت مالی امروز',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green
                          .withOpacity(.08),
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text('درآمد'),
                        const SizedBox(height: 8),
                        Text(
                          MoneyFormatter.format(income),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.red
                          .withOpacity(.08),
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text('هزینه'),
                        const SizedBox(height: 8),
                        Text(
                          MoneyFormatter.format(expense),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'برای مشاهده جزئیات لمس کنید',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}