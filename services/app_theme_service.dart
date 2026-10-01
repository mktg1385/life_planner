import 'package:flutter/material.dart';

class AppThemeService {
  AppThemeService._();

  static const Color primary =
      Color(0xFF4F46E5);

  static const Color secondary =
      Color(0xFF7C3AED);

  static const Color background =
      Color(0xFFF5F6FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness:
          Brightness.light,
      scaffoldBackgroundColor:
          background,
      colorScheme:
          ColorScheme.fromSeed(
        seedColor: primary,
        brightness:
            Brightness.light,
      ),
      appBarTheme:
          const AppBarTheme(
        centerTitle: true,
        backgroundColor:
            Colors.transparent,
        elevation: 0,
      ),
      cardTheme:
          CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            24,
          ),
        ),
      ),
      filledButtonTheme:
          FilledButtonThemeData(
        style:
            FilledButton.styleFrom(
          minimumSize:
              const Size(
            double.infinity,
            54,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    canvasColor: const Color(0xFF121212),

    dialogTheme: const DialogThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF1B1B1B),
      indicatorColor: Color(0xFF4F46E5),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF232323),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),
  );
}
}