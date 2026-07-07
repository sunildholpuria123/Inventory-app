import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';

import 'export_service.dart';

class ExcelExportService {
  static Future<File> exportSalesReport({
    required List<dynamic> invoices,
    bool openAfterExport = true,
  }) async {
    final excel = Excel.createExcel();

    final sheet = excel['Sales Report'];

    sheet.appendRow([
      TextCellValue('Invoice No'),
      TextCellValue('Customer'),
      TextCellValue('Total'),
      TextCellValue('Date'),
    ]);

    for (final invoice in invoices) {
      sheet.appendRow([
        TextCellValue(invoice.invoiceNo),
        TextCellValue(invoice.customerName),
        DoubleCellValue(invoice.grandTotal),
        TextCellValue(
          invoice.createdAt.toString().substring(0, 16),
        ),
      ]);
    }

    final exportDir = await ExportService.getExportDirectory();

    final file = File(
      '${exportDir.path}/sales_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
    );

    final bytes = excel.encode();

    if (bytes == null) {
      throw Exception('Failed to generate Excel report.');
    }

    await file.writeAsBytes(bytes);

    if (openAfterExport) {
      await OpenFilex.open(file.path);
    }

    return file;
  }
}