import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ReportExportService {
  Future<void> exportReport() async {
    final excel = Excel.createExcel();

    final sheet = excel['Reports'];

    sheet.appendRow([TextCellValue('Type'), TextCellValue('Amount')]);

    sheet.appendRow([TextCellValue('Sales'), DoubleCellValue(150000)]);

    sheet.appendRow([TextCellValue('Expenses'), DoubleCellValue(50000)]);

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/report.xlsx');

    await file.writeAsBytes(excel.encode()!);
  }
}
