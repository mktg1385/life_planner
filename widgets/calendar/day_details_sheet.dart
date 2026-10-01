import 'package:flutter/material.dart';

import '../../data/models/reminder_model.dart';
import '../../data/models/task_model.dart';
import '../../../core/utils/money_formatter.dart';

class DayDetailsSheet extends StatelessWidget {
  final DateTime date;

  final int mood;
  final double sleepHours;
  final int waterCount;

  final String? note;

  final int taskCount;
  final int completedTasks;

  final int reminderCount;

  final double income;
  final double expense;

  final List<TaskModel> tasks;
  final List<ReminderModel> reminders;

  const DayDetailsSheet({
    super.key,
    required this.date,
    required this.mood,
    required this.sleepHours,
    required this.waterCount,
    required this.note,
    required this.taskCount,
    required this.completedTasks,
    required this.reminderCount,
    required this.income,
    required this.expense,
    required this.tasks,
    required this.reminders,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final balance = income - expense;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 55,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.outline.withOpacity(.35),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${date.year}/${date.month}/${date.day}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _InfoTile(
                        icon: Icons.mood,
                        title: 'حال روحی',
                        value: '$mood از 5',
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.bedtime,
                        title: 'خواب',
                        value: '${sleepHours.toStringAsFixed(1)} ساعت',
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.water_drop,
                        title: 'آب',
                        value: '$waterCount لیوان',
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.task_alt,
                        title: 'وظایف',
                        value: '$completedTasks از $taskCount انجام شده',
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.notifications_active,
                        title: 'یادآوری‌ها',
                        value: '$reminderCount مورد',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'وظایف روز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (tasks.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'وظیفه‌ای ثبت نشده',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                )
              else
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: tasks.map((task) {
                      return ListTile(
                        leading: Icon(
                          task.isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: task.isCompleted
                              ? Colors.green
                              : colorScheme.outline,
                        ),
                        title: Text(task.title),
                        subtitle: task.description == null
                            ? null
                            : Text(task.description!),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 28),

              Text(
                'یادآوری‌های روز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (reminders.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'یادآوری‌ای ثبت نشده',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                )
              else
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: reminders.map((reminder) {
                      return ListTile(
                        leading: const Icon(
                          Icons.notifications_active,
                          color: Colors.orange,
                        ),
                        title: Text(reminder.title),
                        subtitle: reminder.description == null
                            ? null
                            : Text(reminder.description!),
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 28),

              Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _InfoTile(
                        icon: Icons.account_balance_wallet,
                        title: 'درآمد',
                        value: MoneyFormatter.format(income),
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.money_off,
                        title: 'هزینه',
                        value: MoneyFormatter.format(expense),
                      ),
                      Divider(color: colorScheme.outline.withOpacity(.15)),
                      _InfoTile(
                        icon: Icons.savings,
                        title: 'تراز روز',
                        value: MoneyFormatter.format(balance),
                      ),
                    ],
                  ),
                ),
              ),

              if (note != null && note!.trim().isNotEmpty) ...[
                const SizedBox(height: 28),

                Text(
                  'یادداشت روز',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      note!,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
