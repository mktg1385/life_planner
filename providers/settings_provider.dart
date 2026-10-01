import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../services/smart_notification_service.dart';
import '../services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();

  bool _darkMode = false;
  bool _notificationsEnabled = true;

  bool get darkMode => _darkMode;
  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> initialize() async {
    _darkMode =
        await _settingsService.getTheme();

    _notificationsEnabled =
        await _settingsService.getNotifications();

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;

    await _settingsService.saveTheme(value);

    notifyListeners();
  }

  Future<void> setNotificationsEnabled(
    bool value) async {
  _notificationsEnabled = value;

  await _settingsService.saveNotifications(
    value,
  );

  if (!value) {
    await NotificationService.instance
        .cancelAll();
  } else {
    await NotificationService.instance
        .requestPermission();

    await SmartNotificationService
        .scheduleDailySuggestion();
  }

  notifyListeners();
}
  
}