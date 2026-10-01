class SleepModel {
  final int? id;
  final DateTime sleepTime;
  final DateTime wakeUpTime;
  final int durationMinutes;
  final DateTime createdAt;

  const SleepModel({
    this.id,
    required this.sleepTime,
    required this.wakeUpTime,
    required this.durationMinutes,
    required this.createdAt,
  });

  SleepModel copyWith({
    int? id,
    DateTime? sleepTime,
    DateTime? wakeUpTime,
    int? durationMinutes,
    DateTime? createdAt,
  }) {
    return SleepModel(
      id: id ?? this.id,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      durationMinutes:
          durationMinutes ??
          this.durationMinutes,
      createdAt:
          createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sleep_time':
          sleepTime.toIso8601String(),
      'wake_time':
          wakeUpTime.toIso8601String(),
      'duration':
          durationMinutes,
      'created_at':
          createdAt.toIso8601String(),
    };
  }

  factory SleepModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return SleepModel(
      id: map['id'] as int?,
      sleepTime: DateTime.parse(
        map['sleep_time'] as String,
      ),
      wakeUpTime: DateTime.parse(
        map['wake_time'] as String,
      ),
      durationMinutes:
          map['duration'] as int,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }
}