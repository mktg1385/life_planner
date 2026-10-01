import 'package:flutter/material.dart';

class DashboardSectionTitle
    extends StatelessWidget {
  final String title;

  const DashboardSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Text(
        title,
        style:
            const TextStyle(
          fontSize: 18,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}