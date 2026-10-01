import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String themeKey =
      'theme_mode';

  static const String notificationKey =
      'notifications_enabled';

  static const String languageKey =
      'language';

  Future<void> saveTheme(
    bool darkMode,
  ) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setBool(
      themeKey,
      darkMode,
    );
  }

  Future<bool> getTheme() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getBool(
          themeKey,
        ) ??
        false;
  }

  Future<void> saveNotifications(
    bool enabled,
  ) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setBool(
      notificationKey,
      enabled,
    );
  }

  Future<bool> getNotifications()
      async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getBool(
          notificationKey,
        ) ??
        true;
  }

  Future<void> saveLanguage(
    String language,
  ) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      languageKey,
      language,
    );
  }

  Future<String> getLanguage() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          languageKey,
        ) ??
        'fa';
  }
  
}