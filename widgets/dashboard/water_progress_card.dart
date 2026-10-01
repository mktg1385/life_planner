import 'package:flutter/material.dart';

class WaterProgressCard extends StatelessWidget {
  final int current;
  final int target;

  const WaterProgressCard({
    super.key,
    required this.current,
    this.target = 8,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / target;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'مصرف آب',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress.clamp(0, 1),
          ),
          const SizedBox(height: 12),
          Text(
            '$current از $target لیوان',
          ),
        ],
      ),
    );
  }
}