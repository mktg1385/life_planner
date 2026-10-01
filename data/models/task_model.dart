class TaskModel {
  final int? id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime date;
  final DateTime createdAt;

  const TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.date,
    required this.createdAt,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      isCompleted: (map['is_completed'] as int) == 1,
      date: DateTime.parse(map['date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}