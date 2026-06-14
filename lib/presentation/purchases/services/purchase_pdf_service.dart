import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/database/app_database.dart';

class PurchasePdfService {
  Future<String> generatePurchasePdf({
    required Purchase purchase,
    required List<PurchaseItem> items,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (_) => [
          pw.Text(
            'PURCHASE ORDER',

            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            'Purchase No: '
            '${purchase.purchaseNo}',
          ),

          pw.Text(
            'Supplier: '
            '${purchase.supplierName}',
          ),

          pw.Text(
            'Date: '
            '${purchase.createdAt}',
          ),

          pw.SizedBox(height: 20),

          pw.Table.fromTextArray(
            headers: const ['Product', 'Qty', 'Price', 'Total'],

            data: items.map((e) {
              return [
                e.variantName != null
                    ? '${e.productName}'
                          '\n'
                          '(${e.variantName})'
                    : e.productName,

                e.quantity.toString(),

                '₹${e.purchasePrice}',

                '₹${e.total}',
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 20),

          pw.Align(
            alignment: pw.Alignment.centerRight,

            child: pw.Text(
              'Grand Total: '
              '₹${purchase.total}',

              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final folder = Directory(p.join(dir.path, 'InventoryERP', 'Purchases'));

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final file = File(p.join(folder.path, '${purchase.purchaseNo}.pdf'));

    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(file.path);

    return file.path;
  }
}
