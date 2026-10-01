import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/enums/weather_source.dart';
import '../data/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather() async {
    try {
      final result = await Connectivity().checkConnectivity();

      final hasInternet = !result.contains(ConnectivityResult.none);

      if (hasInternet) {
        return await getOnlineWeather();
      }

      return await getOfflineWeather();
    } catch (_) {
      return await getOfflineWeather();
    }
  }

  Future<WeatherModel> getOnlineWeather() async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=35.69&longitude=51.39&current=temperature_2m',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final temp = (json['current']['temperature_2m'] as num).toDouble();

      final model = WeatherModel(
        city: 'تهران',
        temperature: temp,
        condition: 'آفتابی',
        humidity: 0,
        windSpeed: 0,
        source: WeatherSource.online,
        updatedAt: DateTime.now(),
      );

      await saveOfflineWeather(model);

      return model;
    }

    return await getOfflineWeather();
  }

  Future<void> saveOfflineWeather(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('weather_city', weather.city);

    await prefs.setString('weather_condition', weather.condition);

    await prefs.setDouble('weather_temp', weather.temperature);

    await prefs.setInt('weather_humidity', weather.humidity);

    await prefs.setDouble('weather_wind', weather.windSpeed);

    await prefs.setString(
      'weather_updated',
      weather.updatedAt.toIso8601String(),
    );
  }

  Future<WeatherModel> getOfflineWeather() async {
    final prefs = await SharedPreferences.getInstance();

    return WeatherModel(
      city: prefs.getString('weather_city') ?? 'تهران',
      temperature: prefs.getDouble('weather_temp') ?? 0,
      condition: prefs.getString('weather_condition') ?? 'نامشخص',
      humidity: prefs.getInt('weather_humidity') ?? 0,
      windSpeed: prefs.getDouble('weather_wind') ?? 0,
      source: WeatherSource.offline,
      updatedAt:
          DateTime.tryParse(prefs.getString('weather_updated') ?? '') ??
          DateTime.now(),
    );
  }

  Future<void> saveManualWeather({
    required String condition,
    required double temperature,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('weather_condition', condition);

    await prefs.setDouble('weather_temp', temperature);
  }
}
