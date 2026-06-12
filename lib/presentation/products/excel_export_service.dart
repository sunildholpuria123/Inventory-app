import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/database/app_database.dart';

class ExcelExportService {
  Future<void> exportProducts(List<Product> products) async {
    final excel = Excel.createExcel();

    final sheet = excel['Products'];

    sheet.appendRow([
      TextCellValue('ID'),
      TextCellValue('Name'),
      TextCellValue('Stock'),
      TextCellValue('Price'),
    ]);

    for (final product in products) {
      sheet.appendRow([
        IntCellValue(product.id),
        TextCellValue(product.name),
        IntCellValue(product.stockQty),
        DoubleCellValue(product.sellingPrice),
      ]);
    }

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/products.xlsx');

    await file.writeAsBytes(excel.encode()!);
  }
}
