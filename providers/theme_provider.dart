import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'life_planner_theme';

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool(_themeKey) ?? false;

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    _themeMode = mode;

    await prefs.setBool(_themeKey, mode == ThemeMode.dark);

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final newMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await setTheme(newMode);
  }


  bool get useDark => _themeMode == ThemeMode.dark;
}