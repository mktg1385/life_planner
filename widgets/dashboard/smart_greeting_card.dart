import 'package:flutter/material.dart';

class SmartGreetingCard
    extends StatelessWidget {
  final String text;

  const SmartGreetingCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}