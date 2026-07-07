import 'dart:io';

import 'package:csv/csv.dart';
import 'package:open_filex/open_filex.dart';

import 'export_service.dart';

class CsvExportService {
  static Future<File> exportSalesCsv({
    required List<dynamic> invoices,
    bool openAfterExport = true,
  }) async {
    final rows = <List<dynamic>>[
      ['Invoice No', 'Customer', 'Total', 'Date'],
    ];

    for (final invoice in invoices) {
      rows.add([
        invoice.invoiceNo,
        invoice.customerName,
        invoice.grandTotal.toStringAsFixed(2),
        invoice.createdAt.toString().substring(0, 16),
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);

    final exportDir = await ExportService.getExportDirectory();

    final file = File(
      '${exportDir.path}/sales_report_${DateTime.now().millisecondsSinceEpoch}.csv',
    );

    await file.writeAsString(csv);

    if (openAfterExport) {
      await OpenFilex.open(file.path);
    }

    return file;
  }
}
