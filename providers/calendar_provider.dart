import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../data/models/calendar_event_model.dart';
import '../data/repositories/calendar_repository.dart';

class CalendarProvider
    extends ChangeNotifier {
  final CalendarRepository _repository =
      CalendarRepository();

  List<CalendarEventModel> _events =
      [];

  Jalali _selectedDate =
      Jalali.now();

  List<CalendarEventModel> get events =>
      _events;

  Jalali get selectedDate =>
      _selectedDate;

  Future<void> loadEvents() async {
    _events =
        await _repository.getEvents();

    notifyListeners();
  }

  void selectDate(
    Jalali date,
  ) {
    _selectedDate = date;
    notifyListeners();
  }

  List<CalendarEventModel>
      eventsForSelectedDay() {
    return _events.where((event) {
      final jalali =
          Jalali.fromDateTime(
        event.date,
      );

      return jalali.year ==
              _selectedDate.year &&
          jalali.month ==
              _selectedDate.month &&
          jalali.day ==
              _selectedDate.day;
    }).toList();
  }

  Future<void> addEvent(
    CalendarEventModel event,
  ) async {
    await _repository.insertEvent(
      event,
    );

    await loadEvents();
  }
}