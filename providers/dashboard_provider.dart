import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DashboardProvider extends ChangeNotifier {
  Timer? _timer;

  String _currentTime = '';
  String _currentDate = '';

  String get currentTime => _currentTime;

  String get currentDate => _currentDate;

  DashboardProvider() {
    _initialize();
  }

  void _initialize() {
    _updateDateTime();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _updateDateTime();
      },
    );
  }

  void _updateDateTime() {
    final now = DateTime.now();

    _currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    final jalali = Jalali.now();

    _currentDate =
        '${jalali.formatter.wN} ${jalali.day} ${jalali.formatter.mN} ${jalali.year}';

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}