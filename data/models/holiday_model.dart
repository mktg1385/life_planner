class HolidayModel {
  final String title;
  final int month;
  final int day;
  final bool isOfficialHoliday;

  const HolidayModel({
    required this.title,
    required this.month,
    required this.day,
    required this.isOfficialHoliday,
  });
}