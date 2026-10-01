import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianCalendarHeader extends StatelessWidget {
  final Jalali currentMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onPreviousMonth;

  const PersianCalendarHeader({
    super.key,
    required this.currentMonth,
    required this.onNextMonth,
    required this.onPreviousMonth,
  });

  String getMonthName(int month) {
    const months = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];

    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.outline.withOpacity(.12)),
        boxShadow: theme.brightness == Brightness.light
            ? const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onPreviousMonth,
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: colorScheme.primary,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                '${getMonthName(currentMonth.month)} ${currentMonth.year}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onNextMonth,
              icon: Icon(Icons.keyboard_arrow_left, color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
