import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await requestNotificationPermission();
    final plugin = FlutterLocalNotificationsPlugin();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await plugin.initialize(settings);

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    const ios = DarwinInitializationSettings();

    await notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> requestNotificationPermission() async {
    final status =
    await Permission.notification.request();

    print(status);
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

  /// Generic Notification
  Future<void> showNotification({
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
          'inventory_erp',
          'Inventory ERP',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
  /// Low Stock Alert
  Future<void> showLowStockNotification({
    required String productName,
  }) async {
    await showNotification(
      id: productName.hashCode,
      title: 'Low Stock Alert',
      body: '$productName is running low on stock.',
    );
  }

  /// Payment Reminder
  Future<void> showPaymentReminder({
    required String customerName,
    required double amount,
  }) async {
    await showNotification(
      id: customerName.hashCode,
      title: 'Payment Due',
      body:
      '$customerName has ₹${amount.toStringAsFixed(0)} pending.',
    );
  }
}
