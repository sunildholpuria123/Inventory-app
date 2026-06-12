import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';

import 'export_service.dart';

class ExcelExportService {
  static Future<void> exportSalesReport({
    required List<dynamic> invoices,
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
        TextCellValue(invoice.createdAt.toString()),
      ]);
    }

    final exportDir = await ExportService.getExportDirectory();

    final file = File('${exportDir.path}/sales_report.xlsx');

    await file.writeAsBytes(excel.encode()!);

    await OpenFilex.open(file.path);
  }
}
