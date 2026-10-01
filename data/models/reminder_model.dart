import '../../core/enums/repeat_type.dart';

class ReminderModel {
  final int? id;
  final String title;
  final String? description;
  final DateTime reminderDateTime;
  final RepeatType repeatType;
  final bool isActive;
  final DateTime createdAt;

  const ReminderModel({
    this.id,
    required this.title,
    this.description,
    required this.reminderDateTime,
    required this.repeatType,
    required this.isActive,
    required this.createdAt,
  });

  ReminderModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? reminderDateTime,
    RepeatType? repeatType,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      reminderDateTime: reminderDateTime ?? this.reminderDateTime,
      repeatType: repeatType ?? this.repeatType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reminder_date_time': reminderDateTime.toIso8601String(),
      'repeat_type': repeatType.name,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      reminderDateTime:
          DateTime.parse(map['reminder_date_time'] as String),
      repeatType: RepeatType.values.firstWhere(
        (e) => e.name == map['repeat_type'],
      ),
      isActive: (map['is_active'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}