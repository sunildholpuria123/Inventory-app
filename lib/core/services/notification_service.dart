import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
    InitializationSettings(
      android: android,
    );

    await _notification.initialize(
      settings,
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails =
    AndroidNotificationDetails(
      'inventory_channel',
      'Inventory Notifications',

      importance: Importance.max,
      priority: Priority.high,
    );

    const details =
    NotificationDetails(
      android: androidDetails,
    );

    await _notification.show(
      0,
      title,
      body,
      details,
    );
  }
}