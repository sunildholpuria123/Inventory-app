import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/database/app_database.dart';

class PriceHistoryPdfService {
  Future<String> export(List<ProductPriceHistory> items) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(
            headers: const ['Date', 'Old', 'New', 'Inflation'],
            data: items
                .map(
                  (e) => [
                    e.changedAt.toString(),
                    e.oldPurchasePrice.toString(),
                    e.newPurchasePrice.toString(),
                    '${e.inflationPercentage.toStringAsFixed(2)}%',
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/price_history.pdf');

    await file.writeAsBytes(await pdf.save());

    return file.path;
  }
}
