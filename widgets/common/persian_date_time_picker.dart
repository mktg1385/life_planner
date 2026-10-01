import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'persian_calendar_picker_dialog.dart';
import 'persian_time_picker.dart';

Future<DateTime?> showPersianDateTimePicker(
  BuildContext context, {
  DateTime? initialDateTime,
}) async {
  final DateTime dateTime =
      initialDateTime ?? DateTime.now().add(const Duration(hours: 1));

  //----------------------------------
  // انتخاب تاریخ
  //----------------------------------

  final Jalali? selectedDate = await showDialog<Jalali>(
    context: context,
    builder: (_) =>
        PersianCalendarPickerDialog(initialDate: Jalali.fromDateTime(dateTime)),
  );

  if (selectedDate == null) {
    return null;
  }

  //----------------------------------
  // انتخاب ساعت
  //----------------------------------

  final TimeOfDay? selectedTime = await showDialog<TimeOfDay>(
    context: context,
    builder: (_) =>
        PersianTimePicker(initialTime: TimeOfDay.fromDateTime(dateTime)),
  );

  if (selectedTime == null) {
    return null;
  }

  //----------------------------------
  // تبدیل به DateTime
  //----------------------------------

  final DateTime selectedGregorian = selectedDate.toDateTime();

  return DateTime(
    selectedGregorian.year,
    selectedGregorian.month,
    selectedGregorian.day,
    selectedTime.hour,
    selectedTime.minute,
  );
}
