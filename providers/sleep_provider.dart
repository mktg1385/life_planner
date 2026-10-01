import 'package:flutter/material.dart';

import '../data/models/sleep_model.dart';
import '../data/repositories/sleep_repository.dart';

class SleepProvider
    extends ChangeNotifier {
  final SleepRepository _repository =
      SleepRepository();

  List<SleepModel> _records = [];

  bool _loading = false;

  List<SleepModel> get records =>
      _records;

  bool get loading => _loading;

  Future<void> loadSleepData() async {
    _loading = true;
    notifyListeners();

    _records =
        await _repository.getSleepRecords();

    _loading = false;
    notifyListeners();
  }

  Future<void> addRecord(
    SleepModel record,
  ) async {
    await _repository.insertSleepRecord(
      record,
    );

    await loadSleepData();
  }

  double get averageSleepHours {
    if (_records.isEmpty) {
      return 0;
    }

    final totalMinutes =
        _records.fold<int>(
      0,
      (previous, element) =>
          previous +
          element.durationMinutes,
    );

    return totalMinutes /
        _records.length /
        60;
  }
}