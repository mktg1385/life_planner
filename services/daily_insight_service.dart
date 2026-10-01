class DailyInsightService {
  static String generate({
    required double moodAverage,
    required int waterCount,
    required int completedTasks,
    required int totalTasks,
    required double sleepHours,
  }) {

    final taskPercent =
        totalTasks == 0
            ? 0
            : (completedTasks / totalTasks) * 100;

    if (sleepHours < 5) {
      return 'امروز کم‌خوابی داشتی. بهتره امشب زودتر استراحت کنی 😴';
    }

    if (waterCount < 4) {
      return 'بدنت به آب بیشتری نیاز دارد 💧';
    }

    if (taskPercent >= 90) {
      return 'عملکرد امروز فوق‌العاده بود 🎉';
    }

    if (moodAverage >= 4.5) {
      return 'روحیه امروزت عالیه، از این انرژی استفاده کن 🚀';
    }

    if (moodAverage <= 2) {
      return 'کمی استراحت و آرامش می‌تواند حالت را بهتر کند ❤️';
    }

    return 'امروز در مسیر خوبی هستی، ادامه بده 🌱';
  }
}