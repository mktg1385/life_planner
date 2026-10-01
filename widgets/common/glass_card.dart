import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard
    extends StatelessWidget {
  final Widget child;

  const GlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
        28,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          padding:
              const EdgeInsets.all(
            20,
          ),
          decoration:
              BoxDecoration(
            color: Colors.white
                .withValues(
              alpha: 0.15,
            ),
            borderRadius:
                BorderRadius.circular(
              28,
            ),
            border: Border.all(
              color: Colors.white
                  .withValues(
                alpha: 0.25,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}