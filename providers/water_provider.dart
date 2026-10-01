import 'package:flutter/material.dart';

import '../data/models/water_model.dart';
import '../data/repositories/water_repository.dart';

class WaterProvider extends ChangeNotifier {
  final WaterRepository _repository = WaterRepository();

  WaterModel? _todayWater;

  WaterModel? get todayWater => _todayWater;

  int get glassesCount => _todayWater?.glassesCount ?? 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadTodayWater() async {
    _isLoading = true;
    notifyListeners();

    _todayWater = await _repository.getTodayWaterLog();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> increaseWater() async {
    if (_todayWater == null) {
      final water = WaterModel(
        glassesCount: 1,
        createdAt: DateTime.now(),
      );

      final id = await _repository.insertWater(water);

      _todayWater = water.copyWith(id: id);
    } else {
      _todayWater = _todayWater!.copyWith(
        glassesCount: _todayWater!.glassesCount + 1,
      );

      await _repository.updateWater(_todayWater!);
    }

    notifyListeners();
  }

  Future<void> decreaseWater() async {
    if (_todayWater == null) {
      return;
    }

    if (_todayWater!.glassesCount <= 0) {
      return;
    }

    _todayWater = _todayWater!.copyWith(
      glassesCount: _todayWater!.glassesCount - 1,
    );

    await _repository.updateWater(_todayWater!);

    notifyListeners();
  }
}