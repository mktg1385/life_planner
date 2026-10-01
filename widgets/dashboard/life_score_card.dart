import 'package:flutter/material.dart';

class LifeScoreCard extends StatelessWidget {
  final double score;

  const LifeScoreCard({
    super.key,
    required this.score,
  });

  String getStatus() {
    if (score >= 85) return 'عالی';
    if (score >= 70) return 'خیلی خوب';
    if (score >= 50) return 'متوسط';
    return 'نیاز به بهبود';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF0F766E),
                  const Color(0xFF115E59),
                ]
              : const [
                  Color(0xFF10B981),
                  Color(0xFF059669),
                ],
        ),
        boxShadow: isDark
            ? []
            : const [
                BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'امتیاز زندگی',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '${score.toStringAsFixed(0)} از 100',
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            getStatus(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          LinearProgressIndicator(
            value: score / 100,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
        ],
      ),
    );
  }
}