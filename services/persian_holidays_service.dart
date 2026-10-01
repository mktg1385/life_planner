import '../data/models/holiday_model.dart';

class PersianHolidaysService {
  PersianHolidaysService._();

  static const List<HolidayModel> holidays = [
    HolidayModel(
      title: 'نوروز',
      month: 1,
      day: 1,
      isOfficialHoliday: true,
    ),
    HolidayModel(
      title: 'نوروز',
      month: 1,
      day: 2,
      isOfficialHoliday: true,
    ),
    HolidayModel(
      title: 'نوروز',
      month: 1,
      day: 3,
      isOfficialHoliday: true,
    ),
    HolidayModel(
      title: 'نوروز',
      month: 1,
      day: 4,
      isOfficialHoliday: true,
    ),
    HolidayModel(
      title: 'روز جمهوری اسلامی',
      month: 1,
      day: 12,
      isOfficialHoliday: true,
    ),
    HolidayModel(
      title: 'روز طبیعت',
      month: 1,
      day: 13,
      isOfficialHoliday: true,
    ),
  ];

  static HolidayModel? findHoliday(
    int month,
    int day,
  ) {
    try {
      return holidays.firstWhere(
        (holiday) =>
            holiday.month == month &&
            holiday.day == day,
      );
    } catch (_) {
      return null;
    }
  }
}