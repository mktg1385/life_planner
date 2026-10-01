import 'package:shamsi_date/shamsi_date.dart';

class DateConverterService {
  String jalaliToGregorian(
    Jalali date,
  ) {
    final gregorian =
        date.toGregorian();

    return '${gregorian.year}/${gregorian.month.toString().padLeft(2, '0')}/${gregorian.day.toString().padLeft(2, '0')}';
  }

  String gregorianToJalali(
    DateTime date,
  ) {
    final jalali =
        Jalali.fromDateTime(
      date,
    );

    return '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
  }

  String formatJalali(
    Jalali date,
  ) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}