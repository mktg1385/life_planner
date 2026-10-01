import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'persian_calendar_picker_grid.dart';

class PersianCalendarPickerDialog extends StatefulWidget {
  final Jalali initialDate;

  const PersianCalendarPickerDialog({super.key, required this.initialDate});

  @override
  State<PersianCalendarPickerDialog> createState() =>
      _PersianCalendarPickerDialogState();
}

class _PersianCalendarPickerDialogState
    extends State<PersianCalendarPickerDialog> {
  late Jalali currentMonth;
  late Jalali selectedDate;

  static const months = [
    '',
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

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;

    currentMonth = Jalali(widget.initialDate.year, widget.initialDate.month, 1);
  }

  void previousMonth() {
    setState(() {
      currentMonth = currentMonth.addMonths(-1);
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = currentMonth.addMonths(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("انتخاب تاریخ", style: theme.textTheme.titleLarge),

            const SizedBox(height: 20),

            Row(
              children: [
                IconButton(
                  onPressed: previousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      "${months[currentMonth.month]} ${currentMonth.year}",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: nextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),

            const SizedBox(height: 16),

            PersianCalendarPickerGrid(
              currentMonth: currentMonth,
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context, selectedDate);
                },
                child: const Text("تایید", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
