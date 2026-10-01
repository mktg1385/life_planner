import '../data/models/task_model.dart';
// import '../data/models/mood_model.dart';
import '../data/models/daily_journal_model.dart';
import '../data/models/sleep_model.dart';
import '../widgets/dashboard/weekly_analytics_card.dart';

class WeeklyAnalyticsService {
  static String getPersianWeekDay(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'د';

      case DateTime.tuesday:
        return 'س';

      case DateTime.wednesday:
        return 'چ';

      case DateTime.thursday:
        return 'پ';

      case DateTime.friday:
        return 'ج';

      case DateTime.saturday:
        return 'ش';

      case DateTime.sunday:
        return 'ی';

      default:
        return '';
    }
  }

  static List<WeeklyPoint> build({
    required List<TaskModel> tasks,
    // required List<MoodModel> moods,
    required List<DailyJournalModel> journals,
    required List<SleepModel> sleeps,
  }) {
    final now = DateTime.now();

    final result = <WeeklyPoint>[];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));

      // ------------------
      // TASK SCORE
      // ------------------

      final dayTasks = tasks.where(
        (e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day,
      );

      final totalTasks = dayTasks.length;

      final completedTasks = dayTasks.where((e) => e.isCompleted).length;

      double taskScore = 0;

      if (totalTasks > 0) {
        taskScore = (completedTasks / totalTasks) * 100;
      }

      // ------------------
      // MOOD SCORE
      // ------------------

      // final dayMoods = moods.where(
      //   (e) =>
      //       e.date.year == date.year &&
      //       e.date.month == date.month &&
      //       e.date.day == date.day,
      // );

      // double moodScore = 0;

      // if (dayMoods.isNotEmpty) {
      //   final avgMood =
      //       dayMoods
      //           .map((e) => e.score)
      //           .reduce((a, b) => a + b) /
      //       dayMoods.length;

      //   moodScore = (avgMood / 5) * 100;
      // }
      final dayJournal = journals.where(
        (e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day,
      );

      double moodScore = 0;

      if (dayJournal.isNotEmpty) {
        final mood = dayJournal.first.mood ?? 0;

        moodScore = (mood / 5) * 100;
      }

      // ------------------
      // SLEEP SCORE
      // ------------------

      final daySleeps = sleeps.where(
        (e) =>
            e.createdAt.year == date.year &&
            e.createdAt.month == date.month &&
            e.createdAt.day == date.day,
      );

      double sleepScore = 0;

      if (daySleeps.isNotEmpty) {
        final avgMinutes =
            daySleeps.map((e) => e.durationMinutes).reduce((a, b) => a + b) /
            daySleeps.length;

        final avgHours = avgMinutes / 60;

        sleepScore = ((avgHours / 8) * 100).clamp(0, 100);
      }

      // ------------------
      // FINAL SCORE
      // ------------------
      final hasData =
          totalTasks > 0 || dayJournal.isNotEmpty || daySleeps.isNotEmpty;
      double finalScore =
          (taskScore * 0.5) + (moodScore * 0.25) + (sleepScore * 0.25);

      result.add(
        WeeklyPoint(
          day: getPersianWeekDay(date),
          score: finalScore,
          hasData: hasData,
        ),
      );
    }

    return result;
  }
}
