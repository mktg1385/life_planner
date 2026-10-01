import 'package:flutter/material.dart';

import '../dashboard/daily_journal_dialog.dart';

class HealthSummaryCard extends StatelessWidget {
  final double sleepHours;
  final int waterCount;
  final double moodAverage;
  final String? note;

  const HealthSummaryCard({
    super.key,
    required this.sleepHours,
    required this.waterCount,
    required this.moodAverage,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const DailyJournalDialog(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'سلامت امروز',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _HealthItem(
                    emoji: '😴',
                    title: 'خواب',
                    value: '${sleepHours.toStringAsFixed(1)}h',
                    icon: Icons.bedtime_rounded,
                  ),
                ),
                Expanded(
                  child: _HealthItem(
                    emoji: '💧',
                    title: 'آب',
                    value: '$waterCount/8',
                    icon: Icons.water_drop_rounded,
                  ),
                ),
                Expanded(
                  child: _HealthItem(
                    emoji: _moodEmoji(),
                    title: 'حال روز',
                    value: moodAverage.toStringAsFixed(1),
                    icon: Icons.sentiment_satisfied_rounded,
                  ),
                ),
              ],
            ),

            if (note != null && note!.trim().isNotEmpty) ...[
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'یادداشت امروز',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note!,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),

            Center(
              child: Text(
                'برای ثبت اطلاعات روز روی کارت لمس کنید',
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _moodEmoji() {
    if (moodAverage >= 4) return '😄';
    if (moodAverage >= 3) return '🙂';
    if (moodAverage >= 2) return '😐';
    return '😔';
  }
}

class _HealthItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String value;
  final IconData icon;

  const _HealthItem({
    required this.emoji,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(
            fontSize: 34,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}