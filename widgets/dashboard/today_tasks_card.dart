import 'package:flutter/material.dart';

class TodayTasksCard extends StatelessWidget {
  final int completed;
  final int total;

  const TodayTasksCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    final progress =
        total == 0
            ? 0.0
            : completed / total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Row(
            children: [
              Icon(
                Icons.task_alt,
                color: Color(0xFF4F46E5),
              ),
              SizedBox(width: 8),
              Text(
                'برنامه امروز',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            borderRadius:
                BorderRadius.circular(30),
          ),

          const SizedBox(height: 12),

          Text(
            '$completed از $total تکمیل شده',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}