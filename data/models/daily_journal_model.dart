class DailyJournalModel {
  final int? id;

  final DateTime date;

  final int? mood;

  final String? moodNote;

  final int? waterCount;

  final double? sleepHours;

  final DateTime createdAt;

  const DailyJournalModel({
    this.id,
    required this.date,
    this.mood,
    this.moodNote,
    this.waterCount,
    this.sleepHours,
    required this.createdAt,
  });

  DailyJournalModel copyWith({
    int? id,
    DateTime? date,
    int? mood,
    String? moodNote,
    int? waterCount,
    double? sleepHours,
    DateTime? createdAt,
  }) {
    return DailyJournalModel(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      moodNote: moodNote ?? this.moodNote,
      waterCount: waterCount ?? this.waterCount,
      sleepHours: sleepHours ?? this.sleepHours,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'mood_note': moodNote,
      'water_count': waterCount,
      'sleep_hours': sleepHours,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory DailyJournalModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return DailyJournalModel(
      id: map['id'] as int?,
      date: DateTime.parse(
        map['date'] as String,
      ),
      mood: map['mood'] as int?,
      moodNote: map['mood_note'] as String?,
      waterCount: map['water_count'] as int?,
      sleepHours: map['sleep_hours'] != null
          ? (map['sleep_hours'] as num)
              .toDouble()
          : null,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }
}