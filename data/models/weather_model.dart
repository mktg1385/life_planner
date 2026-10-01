import '../../core/enums/weather_source.dart';

class WeatherModel {
  final int? id;
  final String city;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final WeatherSource source;
  final DateTime updatedAt;
  final String? area;

const WeatherModel({
  this.id,
  this.area,
  required this.city,
  required this.temperature,
  required this.condition,
  required this.humidity,
  required this.windSpeed,
  required this.source,
  required this.updatedAt,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'area': area,
      'temperature': temperature,
      'condition': condition,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'source': source.name,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: map['id'] as int?,
      city: map['city'] as String,
      area: map['area'] as String?,
      temperature: (map['temperature'] as num).toDouble(),
      condition: map['condition'] as String,
      humidity: map['humidity'] as int,
      windSpeed: (map['wind_speed'] as num).toDouble(),
      source: WeatherSource.values.firstWhere(
        (e) => e.name == map['source'],
      ),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}