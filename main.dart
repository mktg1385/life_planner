import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database_helper.dart';
import 'presentation/app/life_planner_app.dart';
import 'providers/dashboard_provider.dart';
import 'providers/water_provider.dart';
import 'providers/task_provider.dart';
import 'providers/reminder_provider.dart';
import 'providers/finance_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/daily_journal_provider.dart';
import 'providers/calendar_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/sleep_provider.dart';
import 'services/notification_service.dart';
import 'services/smart_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  await NotificationService.instance.initialize();

  await SmartNotificationService.scheduleDailySuggestion();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(create: (_) => SettingsProvider()),

        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(create: (_) => WaterProvider()),

        ChangeNotifierProvider(create: (_) => TaskProvider()),

        ChangeNotifierProvider(create: (_) => ReminderProvider()),

        ChangeNotifierProvider(create: (_) => DailyJournalProvider()),

        ChangeNotifierProvider(create: (_) => FinanceProvider()),

        ChangeNotifierProvider(create: (_) => WeatherProvider()),

        ChangeNotifierProvider(create: (_) => CalendarProvider()),

        ChangeNotifierProvider(create: (_) => SleepProvider()),
      ],
      child: const LifePlannerApp(),
    ),
  );
}
