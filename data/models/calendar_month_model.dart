import 'package:shamsi_date/shamsi_date.dart';

class CalendarMonthModel {
  final Jalali date;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isSelected;
  final bool isHoliday;
  final bool hasEvent;
  final String? holidayTitle;

  const CalendarMonthModel({
    required this.date,
    required this.isCurrentMonth,
    required this.isToday,
    required this.isSelected,
    required this.isHoliday,
    required this.hasEvent,
    this.holidayTitle,
  });

  CalendarMonthModel copyWith({
    Jalali? date,
    bool? isCurrentMonth,
    bool? isToday,
    bool? isSelected,
    bool? isHoliday,
    bool? hasEvent,
    String? holidayTitle,
  }) {
    return CalendarMonthModel(
      date: date ?? this.date,
      isCurrentMonth:
          isCurrentMonth ?? this.isCurrentMonth,
      isToday: isToday ?? this.isToday,
      isSelected: isSelected ?? this.isSelected,
      isHoliday: isHoliday ?? this.isHoliday,
      hasEvent: hasEvent ?? this.hasEvent,
      holidayTitle: holidayTitle ?? this.holidayTitle,
    );
  }
}