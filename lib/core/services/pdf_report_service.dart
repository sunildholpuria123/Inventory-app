import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfReportService {
  static Future<File> exportSalesPdf({
    required List<dynamic> invoices,
    bool openAfterExport = true,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Text(
              'Sales Report',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Table.fromTextArray(
              headers: const [
                'Invoice',
                'Customer',
                'Total',
                'Date',
              ],
              data: invoices.map((e) {
                return [
                  e.invoiceNo,
                  e.customerName,
                  '₹${e.grandTotal.toStringAsFixed(2)}',
                  e.createdAt.toString().substring(0, 16),
                ];
              }).toList(),
            ),
          ];
        },
      ),
    );

    final appDir = await getApplicationDocumentsDirectory();

    final exportDir = Directory(
      p.join(appDir.path, 'InventoryERP', 'Exports'),
    );

    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }

    final fileName =
        'sales_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

    final file = File(
      p.join(exportDir.path, fileName),
    );

    await file.writeAsBytes(await pdf.save());

    if (openAfterExport) {
      await OpenFilex.open(file.path);
    }

    return file;
  }
}