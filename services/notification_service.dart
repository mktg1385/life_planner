import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static const AndroidNotificationDetails _alarmDetails =
      AndroidNotificationDetails(
        'life_planner_alarm_channel',
        'Reminder Alarm',
        channelDescription: 'Reminder Alarm Notifications',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
      );
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get plugin => _notifications;

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings: settings);

    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();

    await androidPlugin?.requestExactAlarmsPermission();
  }

  NotificationDetails get _details =>
      const NotificationDetails(android: _alarmDetails);

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(dateTime, tz.local),
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int weekday,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 7));
    }

    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> cancel(int id) async {
    await _notifications.cancel(id: id);
  }

  Future<void> requestPermission() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();

    await androidPlugin?.requestExactAlarmsPermission();
  }

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  Future<List<PendingNotificationRequest>> pendingNotifications() async {
    return _notifications.pendingNotificationRequests();
  }

  Future<void> scheduleSmartSuggestion({required String body}) async {
    await scheduleDailyNotification(
      id: 9999,
      title: 'پیشنهاد امروز',
      body: body,
      hour: 9,
      minute: 0,
    );
  }
}
