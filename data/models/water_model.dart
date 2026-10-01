class WaterModel {
  final int? id;
  final int glassesCount;
  final DateTime createdAt;

  const WaterModel({
    this.id,
    required this.glassesCount,
    required this.createdAt,
  });

  WaterModel copyWith({
    int? id,
    int? glassesCount,
    DateTime? createdAt,
  }) {
    return WaterModel(
      id: id ?? this.id,
      glassesCount: glassesCount ?? this.glassesCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'glasses_count': glassesCount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WaterModel.fromMap(Map<String, dynamic> map) {
    return WaterModel(
      id: map['id'] as int?,
      glassesCount: map['glasses_count'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}