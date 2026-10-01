import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/shell/app_shell.dart';
import '../../services/app_theme_service.dart';
import '../../services/navigation_service.dart';
import '../pages/settings/settings_page.dart';

class LifePlannerApp extends StatelessWidget {
  const LifePlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Life Planner',

          navigatorKey: NavigationService.instance.navigatorKey,

          theme: AppThemeService.lightTheme,
          darkTheme: AppThemeService.darkTheme,
          themeMode: themeProvider.themeMode,

          locale: const Locale('fa'),

          supportedLocales: const [Locale('fa'), Locale('en')],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          routes: {
            '/': (context) => const SplashPage(),
            '/home': (context) => const AppShell(),
            '/settings': (context) => const SettingsPage(),
          },

          initialRoute: '/',
        );
      },
    );
  }
}
