import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const ios = DarwinInitializationSettings();

    await notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> showReminder({
    required int id,
    required String title,
    required String body,
  }) async {
    await notifications.show(
      id,
      title,
      body,

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'due_reminders',
          'Due Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),

        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
