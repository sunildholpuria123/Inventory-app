import 'package:url_launcher/url_launcher.dart';

class ReminderService {
  static Future<void> sendWhatsAppReminder({
    required String phone,

    required String customerName,

    required double amount,
  }) async {
    final message = Uri.encodeComponent('''
Dear $customerName,

This is a reminder that your payment of ₹$amount is overdue.

Please make the payment at your earliest convenience.

Thank you.
''');

    final url = Uri.parse('https://wa.me/91$phone?text=$message');

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
