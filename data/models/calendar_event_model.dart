class CalendarEventModel {
  final int? id;
  final String title;
  final String description;
  final DateTime date;
  final bool isHoliday;
  final bool isOfficialEvent;

  const CalendarEventModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isHoliday,
    required this.isOfficialEvent,
  });

  CalendarEventModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isHoliday,
    bool? isOfficialEvent,
  }) {
    return CalendarEventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description:
          description ?? this.description,
      date: date ?? this.date,
      isHoliday:
          isHoliday ?? this.isHoliday,
      isOfficialEvent:
          isOfficialEvent ??
              this.isOfficialEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'is_holiday': isHoliday ? 1 : 0,
      'is_official_event':
          isOfficialEvent ? 1 : 0,
    };
  }

  factory CalendarEventModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return CalendarEventModel(
      id: map['id'],
      title: map['title'] ?? '',
      description:
          map['description'] ?? '',
      date: DateTime.parse(
        map['date'],
      ),
      isHoliday:
          map['is_holiday'] == 1,
      isOfficialEvent:
          map['is_official_event'] == 1,
    );
  }
}