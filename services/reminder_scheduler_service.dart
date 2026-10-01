import '../core/enums/repeat_type.dart';
import 'notification_service.dart';

class ReminderSchedulerService {
  ReminderSchedulerService._();

  static Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    required RepeatType repeatType,
  }) async {
    switch (repeatType) {
      case RepeatType.none:
  // یادآوری ۳۰ دقیقه قبل
  final beforeTime = dateTime.subtract(
    const Duration(minutes: 30),
  );

  if (beforeTime.isAfter(DateTime.now())) {
    await NotificationService.instance.scheduleNotification(
      id: id + 100000,
      title: 'یادآوری نزدیک',
      body: '۳۰ دقیقه تا "$title" باقی مانده است.',
      dateTime: beforeTime,
    );
  }

  // یادآوری اصلی
  await NotificationService.instance.scheduleNotification(
    id: id,
    title: title,
    body: body,
    dateTime: dateTime,
  );
  break;

      case RepeatType.daily:
        await NotificationService.instance
            .scheduleDailyNotification(
          id: id,
          title: title,
          body: body,
          hour: dateTime.hour,
          minute: dateTime.minute,
        );
        break;

      case RepeatType.weekly:
        await NotificationService.instance
            .scheduleWeeklyNotification(
          id: id,
          title: title,
          body: body,
          weekday: dateTime.weekday,
          hour: dateTime.hour,
          minute: dateTime.minute,
        );
        break;

      case RepeatType.monthly:
        await NotificationService.instance
            .scheduleNotification(
          id: id,
          title: title,
          body: body,
          dateTime: dateTime,
        );
        break;
    }
  }

  static Future<void> cancel(int id) async {
  await NotificationService.instance.cancel(id);

  // حذف یادآوری ۳۰ دقیقه قبل
  await NotificationService.instance.cancel(
    id + 100000,
  );
}
}