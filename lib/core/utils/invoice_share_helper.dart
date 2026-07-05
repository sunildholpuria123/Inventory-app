import 'package:share_plus/share_plus.dart';

class InvoiceShareHelper {
  static Future<void> sharePdf({
    required String pdfPath,
    required String invoiceNo,
  }) async {
    await Share.shareXFiles([XFile(pdfPath)], text: 'Invoice $invoiceNo');
  }
}
