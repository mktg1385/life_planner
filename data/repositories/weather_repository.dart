import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/enums/weather_source.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  static const String _cacheKey =
      'cached_weather';

  Future<WeatherModel?> getOnlineWeather(
    String city,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://wttr.in/$city?format=j1',
        ),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final json =
          jsonDecode(response.body);

      final weather = WeatherModel(
        city: city,
        temperature: double.parse(
          json['current_condition'][0]
                  ['temp_C']
              .toString(),
        ),
        condition: json[
                'current_condition'][0]
            ['weatherDesc'][0]['value'],
        humidity: int.parse(
          json['current_condition'][0]
                  ['humidity']
              .toString(),
        ),
        windSpeed: double.parse(
          json['current_condition'][0]
                  ['windspeedKmph']
              .toString(),
        ),
        source: WeatherSource.online,
        updatedAt: DateTime.now(),
      );

      await saveWeather(weather);

      return weather;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveWeather(
    WeatherModel weather,
  ) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      _cacheKey,
      jsonEncode(
        weather.toMap(),
      ),
    );
  }

  Future<WeatherModel?>
      getCachedWeather() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    final data =
        prefs.getString(_cacheKey);

    if (data == null) {
      return null;
    }

    return WeatherModel.fromMap(
      jsonDecode(data),
    );
  }

  Future<void> saveManualWeather(
    WeatherModel weather,
  ) async {
    await saveWeather(weather);
  }
  Future<WeatherModel?> getOnlineWeatherByCoords({
  required double latitude,
  required double longitude,
}) async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://wttr.in/$latitude,$longitude?format=j1',
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final json =
        jsonDecode(response.body);

    final weather = WeatherModel(
      city: 'موقعیت فعلی',
      temperature: double.parse(
        json['current_condition'][0]
                ['temp_C']
            .toString(),
      ),
      condition: json['current_condition'][0]
          ['weatherDesc'][0]['value'],
      humidity: int.parse(
        json['current_condition'][0]
                ['humidity']
            .toString(),
      ),
      windSpeed: double.parse(
        json['current_condition'][0]
                ['windspeedKmph']
            .toString(),
      ),
      source: WeatherSource.online,
      updatedAt: DateTime.now(),
    );

    await saveWeather(weather);

    return weather;
  } catch (_) {
    return null;
  }
}
}