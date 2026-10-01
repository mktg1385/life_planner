import 'notification_service.dart';

class SmartNotificationService {
  static String build({
    required double sleepHours,
    required int water,
    required int completedTasks,
    required int totalTasks,
    required double balance,
    required int mood,
  }) {
    if (sleepHours < 6) {
      return 'امشب کمی زودتر بخواب 😴';
    }

    if (water < 4) {
      return 'امروز آب بیشتری بنوش 💧';
    }

    if (totalTasks > 0 &&
        completedTasks == 0) {
      return 'زمان انجام وظایف امروز رسیده ✅';
    }

    if (balance < 0) {
      return 'هزینه‌هایت بیشتر از درآمدت شده 💰';
    }

    if (mood <= 2) {
      return 'امروز کمی به خودت استراحت بده ❤️';
    }

    return 'امروز عملکرد خوبی داشتی 🌱';
  }

  static Future<void>
      scheduleDailySuggestion() async {
    await NotificationService.instance
        .scheduleDailyNotification(
      id: 9999,
      title: 'پیشنهاد امروز',
      body: 'امروز عملکرد خوبی داشتی 🌱',
      hour: 9,
      minute: 0,
    );
  }
}