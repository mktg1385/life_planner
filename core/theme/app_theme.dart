import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF7C3AED);

  // Light
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color cardColor = Colors.white;

  // Dark
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);

  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,

      colorScheme: scheme,

      brightness: Brightness.light,

      scaffoldBackgroundColor: backgroundColor,

      cardColor: cardColor,

      canvasColor: backgroundColor,

      dividerColor: Colors.grey.shade300,

      textTheme: GoogleFonts.vazirmatnTextTheme(),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      colorScheme: scheme,

      scaffoldBackgroundColor: darkBackground,

      canvasColor: darkBackground,

      cardColor: darkCard,

      dividerColor: Colors.grey.shade800,

      textTheme: GoogleFonts.vazirmatnTextTheme(
        ThemeData.dark().textTheme,
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}