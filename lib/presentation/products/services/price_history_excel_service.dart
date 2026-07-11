import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/database/app_database.dart';

class PriceHistoryExcelService {
  Future<String> export(List<ProductPriceHistory> items) async {
    final excel = Excel.createExcel();

    final sheet = excel['PriceHistory'];

    sheet.appendRow([
      TextCellValue('Date'),
      TextCellValue('Old Price'),
      TextCellValue('New Price'),
      TextCellValue('Inflation'),
      TextCellValue('Remarks'),
    ]);

    for (final item in items) {
      sheet.appendRow([
        TextCellValue(item.changedAt.toString()),
        DoubleCellValue(item.oldPurchasePrice),
        DoubleCellValue(item.newPurchasePrice),
        DoubleCellValue(item.inflationPercentage),
        TextCellValue(item.remarks ?? ''),
      ]);
    }

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/price_history.xlsx');

    await file.writeAsBytes(excel.save()!);

    return file.path;
  }
}
