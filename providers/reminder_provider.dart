import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/reminder_model.dart';
import '../data/repositories/reminder_repository.dart';
import '../services/reminder_scheduler_service.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepository _repository =
      ReminderRepository();

  List<ReminderModel> _reminders = [];

  bool _isLoading = false;

  List<ReminderModel> get reminders =>
      _reminders;

  bool get isLoading => _isLoading;

  Future<void> loadReminders() async {
    try {
      _isLoading = true;
      notifyListeners();

      _reminders =
          await _repository.getReminders();
    } catch (e, s) {
      debugPrint('REMINDER LOAD ERROR: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addReminder(
    ReminderModel reminder,
  ) async {
    try {
      final reminderId =
          await _repository.insertReminder(
        reminder,
      );

      await ReminderSchedulerService.schedule(
        id: reminderId,
        title: reminder.title,
        body:
            reminder.description ??
                reminder.title,
        dateTime:
            reminder.reminderDateTime,
        repeatType:
            reminder.repeatType,
      );

      await loadReminders();
    } catch (e, s) {
      debugPrint('REMINDER ADD ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> updateReminder(
    ReminderModel reminder,
  ) async {
    try {
      await _repository.updateReminder(
        reminder,
      );

      if (reminder.id != null) {
        await ReminderSchedulerService.cancel(
          reminder.id!,
        );

        await ReminderSchedulerService.schedule(
          id: reminder.id!,
          title: reminder.title,
          body:
              reminder.description ??
                  reminder.title,
          dateTime:
              reminder.reminderDateTime,
          repeatType:
              reminder.repeatType,
        );
      }

      await loadReminders();
    } catch (e, s) {
      debugPrint('REMINDER UPDATE ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> deleteReminder(
    int id,
  ) async {
    try {
      await ReminderSchedulerService.cancel(
        id,
      );

      await _repository.deleteReminder(
        id,
      );

      await loadReminders();
    } catch (e, s) {
      debugPrint('REMINDER DELETE ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }
}