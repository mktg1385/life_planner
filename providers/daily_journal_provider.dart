import 'package:flutter/material.dart';

import '../data/models/daily_journal_model.dart';
import '../data/repositories/daily_journal_repository.dart';

class DailyJournalProvider
    extends ChangeNotifier {
  final DailyJournalRepository
      _repository =
      DailyJournalRepository();

  DailyJournalModel? _today;

  List<DailyJournalModel> _journals = [];

  DailyJournalModel? get today =>
      _today;

  List<DailyJournalModel> get journals =>
      _journals;

  Future<void> loadToday() async {
    _today =
        await _repository.getByDate(
      DateTime.now(),
    );

    notifyListeners();
  }

  Future<void> loadAll() async {
    _journals =
        await _repository.getAll();

    notifyListeners();
  }

  Future<void> save({
    required int mood,
    required int water,
    required double sleepHours,
    required String note,
  }) async {
    final now = DateTime.now();

    final journalDate = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final journal = DailyJournalModel(
      id: _today?.id,
      date: journalDate,
      mood: mood,
      moodNote: note,
      waterCount: water,
      sleepHours: sleepHours,
      createdAt:
          _today?.createdAt ??
              DateTime.now(),
    );

    if (_today == null) {
      await _repository.insert(
        journal,
      );
    } else {
      await _repository.update(
        journal,
      );
    }

    await loadToday();
    await loadAll();
  }

  Future<void> delete(
    int id,
  ) async {
    await _repository.delete(id);

    await loadAll();

    await loadToday();
  }
}