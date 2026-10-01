import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const _lastOpenKey =
      'last_open_date';

  static const _streakKey =
      'current_streak';

  static const _bestKey =
      'best_streak';

  static Future<void>
      updateDailyOpen() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    final today =
        DateTime.now();

    final lastOpen =
        prefs.getString(
      _lastOpenKey,
    );

    int streak =
        prefs.getInt(
          _streakKey,
        ) ??
        0;

    if (lastOpen != null) {
      final lastDate =
          DateTime.parse(
        lastOpen,
      );

      final difference =
          today
              .difference(
                DateTime(
                  lastDate.year,
                  lastDate.month,
                  lastDate.day,
                ),
              )
              .inDays;

      if (difference == 1) {
        streak++;
      } else if (difference > 1) {
        streak = 1;
      }
    } else {
      streak = 1;
    }

    final best =
        prefs.getInt(
          _bestKey,
        ) ??
        0;

    await prefs.setInt(
      _streakKey,
      streak,
    );

    await prefs.setInt(
      _bestKey,
      streak > best
          ? streak
          : best,
    );

    await prefs.setString(
      _lastOpenKey,
      today.toIso8601String(),
    );
  }

  static Future<int>
      getCurrentStreak() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getInt(
          _streakKey,
        ) ??
        0;
  }

  static Future<int>
      getBestStreak() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getInt(
          _bestKey,
        ) ??
        0;
  }
  static int calculate(
  List<DateTime> dates,
) {
  if (dates.isEmpty) {
    return 0;
  }

  dates.sort();

  int streak = 1;

  for (
    int i = dates.length - 1;
    i > 0;
    i--
  ) {
    final diff =
        dates[i]
            .difference(
              dates[i - 1],
            )
            .inDays;

    if (diff == 1) {
      streak++;
    } else {
      break;
    }
  }

  return streak;
}
}
