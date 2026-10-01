import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class LiveClockHeader extends StatefulWidget {
  const LiveClockHeader({
    super.key,
  });

  @override
  State<LiveClockHeader> createState() =>
      _LiveClockHeaderState();
}

class _LiveClockHeaderState
    extends State<LiveClockHeader> {
  late Timer timer;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(() {
            now = DateTime.now();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String get persianWeekDay {
    const days = [
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنجشنبه',
      'جمعه',
      'شنبه',
      'یکشنبه',
    ];

    return days[now.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final jalali =
        Jalali.fromDateTime(now);

    final miladiDate =
        '${now.year}/${now.month}/${now.day}';

    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(32),
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
        ),
      ),
      child: Stack(
        children: [

          /// دکمه تنظیمات
          Positioned(
            top: 28,
            left: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/settings',
                );
              },
              icon: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          /// محتوا
          Column(
            children: [

              const SizedBox(height: 18),

              Text(
                time,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                persianWeekDay,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [

                  Text(
                    persianDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                miladiDate,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String get persianDate {
    final jalali =
        Jalali.fromDateTime(now);

    const months = [
      '',
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];

    return '${jalali.day} ${months[jalali.month]} ${jalali.year}';
  }
}