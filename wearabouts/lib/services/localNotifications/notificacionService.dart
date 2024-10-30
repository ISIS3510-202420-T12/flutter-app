import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await notificationsPlugin.initialize(
      initializationSettings,
    );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.high, priority: Priority.low));
    await notificationsPlugin.show(0, title, body, details);
  }

  static Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    const NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.high, priority: Priority.low));

    await notificationsPlugin.zonedSchedule(
        0, title, body, tz.TZDateTime.from(scheduledTime, tz.local), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }
}
