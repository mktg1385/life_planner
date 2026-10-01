import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';

class ReminderPreviewCard extends StatelessWidget {
  final List<ReminderModel> reminders;
  final VoidCallback? onTap;

  const ReminderPreviewCard({super.key, required this.reminders, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    final previewReminders = reminders.take(3).toList();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
                Icon(Icons.notifications_active, color: Colors.orange),

                const SizedBox(width: 8),

                Text(
                  'یادآوری‌های امروز',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                TextButton(onPressed: onTap, child: const Text('مشاهده بیشتر')),
              ],
            ),

            const SizedBox(height: 14),

            if (reminders.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'برای امروز یادآوری ثبت نشده',
                  style: theme.textTheme.bodyMedium,
                ),
              ),

            ...previewReminders.map(
              (reminder) => Container(
                margin: const EdgeInsets.only(bottom: 10),

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.alarm, color: Colors.orange),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        reminder.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (reminders.length > 3)
              Center(
                child: TextButton(
                  onPressed: onTap,
                  child: Text('+ ${reminders.length - 3} مورد دیگر'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
