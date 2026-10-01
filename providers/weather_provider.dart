import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../core/enums/weather_source.dart';
import '../data/models/weather_model.dart';
import '../data/repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherModel? _weather;

  bool _isLoading = false;

  WeatherModel? get weather => _weather;

  bool get isLoading => _isLoading;

  Future<void> loadCurrentLocationWeather() async {
    _isLoading = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _weather = await _repository.getCachedWeather();

        _isLoading = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _weather = await _repository.getCachedWeather();

        _isLoading = false;
        notifyListeners();
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      final weather = await _repository.getOnlineWeatherByCoords(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (weather != null) {
        final places = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        String city = weather.city;
        String area = '';

        if (places.isNotEmpty) {
          final place = places.first;
          debugPrint('CITY: ${place.locality}');
          debugPrint('SUB CITY: ${place.subAdministrativeArea}');
          debugPrint('PROVINCE: ${place.administrativeArea}');
          debugPrint('AREA: ${place.subLocality}');
          debugPrint('STREET: ${place.thoroughfare}');
          debugPrint('NAME: ${place.name}');
          area = place.subLocality ?? place.thoroughfare ?? '';

          city = (place.locality?.isNotEmpty ?? false)
              ? place.locality!
              : (place.subAdministrativeArea?.isNotEmpty ?? false)
              ? place.subAdministrativeArea!
              : (place.administrativeArea?.isNotEmpty ?? false)
              ? place.administrativeArea!
              : (place.name?.isNotEmpty ?? false)
              ? place.name!
              : weather.city;
        }

        _weather = WeatherModel(
          id: weather.id,
          city: city,
          area: area,
          temperature: weather.temperature,
          condition: weather.condition,
          humidity: weather.humidity,
          windSpeed: weather.windSpeed,
          source: weather.source,
          updatedAt: weather.updatedAt,
        );
      }
    } catch (_) {
      _weather = await _repository.getCachedWeather();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadWeather(String city) async {
    _isLoading = true;

    notifyListeners();

    final connectivity = await Connectivity().checkConnectivity();

    final hasInternet =
        connectivity.contains(ConnectivityResult.mobile) ||
        connectivity.contains(ConnectivityResult.wifi);

    if (hasInternet) {
      _weather = await _repository.getOnlineWeather(city);
    }

    _weather ??= await _repository.getCachedWeather();

    _isLoading = false;

    notifyListeners();
  }

  Future<void> saveManualWeather({
    required String city,
    required double temperature,
    required String condition,
    required int humidity,
  }) async {
    final weather = WeatherModel(
      city: city,
      temperature: temperature,
      condition: condition,
      humidity: humidity,
      windSpeed: 0,
      source: WeatherSource.offline,
      updatedAt: DateTime.now(),
    );

    await _repository.saveManualWeather(weather);

    _weather = weather;

    notifyListeners();
  }
}
