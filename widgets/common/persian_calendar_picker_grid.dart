import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianCalendarPickerGrid extends StatelessWidget {
  final Jalali currentMonth;
  final Jalali selectedDate;
  final ValueChanged<Jalali> onDateSelected;

  const PersianCalendarPickerGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final firstDay = Jalali(currentMonth.year, currentMonth.month, 1);

    final days = currentMonth.monthLength;

    /// همان منطقی که PersianCalendarGrid استفاده می‌کند
    int offset = firstDay.weekDay - 1;

    /// اصلاح اختلاف هفته در بعضی ماه‌ها
    offset = offset % 7;
    const weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

    return Column(
      children: [
        Row(
          children: weekDays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
              .toList(),
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

            final selected =
                date.year == selectedDate.year &&
                date.month == selectedDate.month &&
                date.day == selectedDate.day;

            return GestureDetector(
              onTap: () => onDateSelected(date),

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                margin: const EdgeInsets.all(4),

                decoration: BoxDecoration(
                  color: selected ? colorScheme.primary : colorScheme.surface,

                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(.2),
                  ),
                ),

                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
