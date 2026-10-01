import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../providers/daily_journal_provider.dart';
import '../../providers/reminder_provider.dart';
import '../../providers/task_provider.dart';

class PersianCalendarGrid extends StatelessWidget {
  final Jalali currentMonth;
  final Jalali selectedDate;
  final Function(Jalali) onDateSelected;

  const PersianCalendarGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final days = currentMonth.monthLength;

    final firstDay = Jalali(currentMonth.year, currentMonth.month, 1);

    final offset = firstDay.weekDay - 1;

    final journals = context.watch<DailyJournalProvider>().journals;

    final tasks = context.watch<TaskProvider>().tasks;

    final reminders = context.watch<ReminderProvider>().reminders;

    const weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

    return Column(
      children: [
        Row(
          children: weekDays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days + offset,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            if (index < offset) {
              return const SizedBox();
            }

            final day = index - offset + 1;

            final date = Jalali(currentMonth.year, currentMonth.month, day);

            final dateTime = date.toDateTime();

            final selected =
                selectedDate.year == date.year &&
                selectedDate.month == date.month &&
                selectedDate.day == date.day;

            final hasJournal = journals.any(
              (e) =>
                  e.date.year == dateTime.year &&
                  e.date.month == dateTime.month &&
                  e.date.day == dateTime.day,
            );

            final hasTask = tasks.any(
              (e) =>
                  e.date.year == dateTime.year &&
                  e.date.month == dateTime.month &&
                  e.date.day == dateTime.day,
            );

            final hasReminder = reminders.any(
              (e) =>
                  e.reminderDateTime.year == dateTime.year &&
                  e.reminderDateTime.month == dateTime.month &&
                  e.reminderDateTime.day == dateTime.day,
            );

            return GestureDetector(
              onTap: () {
                onDateSelected(date);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: selected ? colorScheme.primary : colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(.15),
                  ),
                  boxShadow: theme.brightness == Brightness.light
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasJournal) const _Dot(color: Colors.green),
                        if (hasTask) const _Dot(color: Colors.orange),
                        if (hasReminder) const _Dot(color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: const [
            _LegendDot(color: Colors.green, text: 'ژورنال روزانه'),
            _LegendDot(color: Colors.orange, text: 'وظیفه'),
            _LegendDot(color: Colors.red, text: 'یادآوری'),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendDot({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: colorScheme.onSurface)),
      ],
    );
  }
}
