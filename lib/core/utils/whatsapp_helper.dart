import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static Future<void> openChat({required String phone, String? message}) async {
    var cleanedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (!cleanedPhone.startsWith('91')) {
      cleanedPhone = '91$cleanedPhone';
    }

    final url =
        'https://wa.me/'
        '$cleanedPhone'
        '?text=${Uri.encodeComponent(message ?? '')}';

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> sendPaymentReminder({
    required String phone,
    required String customerName,
    required double amount,
  }) async {
    final message =
        '''
Hello $customerName,

This is a friendly reminder that your outstanding amount of ₹${amount.toStringAsFixed(0)} is pending.

Please make the payment at your earliest convenience.

Thank you.
''';

    await openChat(phone: phone, message: message);
  }

  static Future<void> sendInvoiceMessage({
    required String phone,
    required String customerName,
    required String invoiceNo,
    required double amount,
  }) async {
    final message =
        '''
Hello $customerName,

Invoice No: $invoiceNo

Amount: ₹${amount.toStringAsFixed(0)}

Thank you for your business.
''';

    await openChat(phone: phone, message: message);
  }
}
