import 'package:shamsi_date/shamsi_date.dart';

import '../data/models/calendar_month_model.dart';
import 'persian_holidays_service.dart';

class CalendarEngineService {
  CalendarEngineService._();

  static List<CalendarMonthModel> buildMonthGrid({
    required Jalali month,
    required Jalali selectedDate,
  }) {
    final List<CalendarMonthModel> days = [];

    final firstDay = Jalali(month.year, month.month, 1);

    final firstWeekDay = firstDay.weekDay;

    final previousMonth = month.addMonths(-1);
    final previousMonthLength = Jalali(
      previousMonth.year,
      previousMonth.month,
      1,
    ).monthLength;

    for (int i = firstWeekDay - 1; i > 0; i--) {
      final date = Jalali(
        previousMonth.year,
        previousMonth.month,
        previousMonthLength - i + 1,
      );

      days.add(
        _createDay(
          date: date,
          selectedDate: selectedDate,
          isCurrentMonth: false,
        ),
      );
    }

    final currentMonthLength = firstDay.monthLength;

    for (int day = 1; day <= currentMonthLength; day++) {
      final date = Jalali(month.year, month.month, day);

      days.add(
        _createDay(
          date: date,
          selectedDate: selectedDate,
          isCurrentMonth: true,
        ),
      );
    }

    int nextDay = 1;
    print('weekday = $firstWeekDay');
    while (days.length < 42) {
      final nextMonth = month.addMonths(1);

      final date = Jalali(nextMonth.year, nextMonth.month, nextDay);

      days.add(
        _createDay(
          date: date,
          selectedDate: selectedDate,
          isCurrentMonth: false,
        ),
      );

      nextDay++;
    }

    return days;
  }

  static CalendarMonthModel _createDay({
    required Jalali date,
    required Jalali selectedDate,
    required bool isCurrentMonth,
  }) {
    final holiday = PersianHolidaysService.findHoliday(date.month, date.day);

    final today = Jalali.now();

    return CalendarMonthModel(
      date: date,
      isCurrentMonth: isCurrentMonth,
      isToday:
          today.year == date.year &&
          today.month == date.month &&
          today.day == date.day,
      isSelected:
          selectedDate.year == date.year &&
          selectedDate.month == date.month &&
          selectedDate.day == date.day,
      isHoliday: holiday != null,
      hasEvent: false,
      holidayTitle: holiday?.title,
    );
  }
}
