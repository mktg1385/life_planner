import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';

class TodayTasksPreviewCard extends StatelessWidget {
  final List<TaskModel> tasks;
  final VoidCallback onViewAll;

  const TodayTasksPreviewCard({
    super.key,
    required this.tasks,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    final previewTasks = tasks.take(3).toList();

    return Container(
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
              Icon(
                Icons.task_alt,
                color: colorScheme.primary,
              ),

              const SizedBox(width: 8),

              Text(
                'وظایف امروز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: onViewAll,
                child: const Text('مشاهده بیشتر'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'برای امروز وظیفه‌ای ثبت نشده',
                style: theme.textTheme.bodyMedium,
              ),
            ),

          ...previewTasks.map(
            (task) => Container(
              margin: const EdgeInsets.only(bottom: 10),

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: task.isCompleted
                    ? Colors.green.withOpacity(0.10)
                    : colorScheme.surfaceContainerHighest.withOpacity(0.4),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Row(
                children: [
                  Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : colorScheme.onSurfaceVariant,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (tasks.length > 3)
            Center(
              child: TextButton(
                onPressed: onViewAll,
                child: Text(
                  '+ ${tasks.length - 3} وظیفه دیگر',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}