import 'dart:io';

import 'package:csv/csv.dart';

import 'package:open_filex/open_filex.dart';

import 'export_service.dart';

class CsvExportService {
  static Future<void>
  exportSalesCsv({
    required List<dynamic>
    invoices,
  }) async {
    List<List<dynamic>> rows =
    [];

    rows.add([
      'Invoice No',
      'Customer',
      'Total',
      'Date',
    ]);

    for (final invoice
    in invoices) {
      rows.add([
        invoice.invoiceNo,
        invoice.customerName,
        invoice.grandTotal,
        invoice.createdAt
            .toString(),
      ]);
    }

    String csv =
    const ListToCsvConverter()
        .convert(rows);

    final exportDir =
    await ExportService
        .getExportDirectory();

    final file = File(
      '${exportDir.path}/sales_report.csv',
    );

    await file.writeAsString(
      csv,
    );

    await OpenFilex.open(
      file.path,
    );
  }
}