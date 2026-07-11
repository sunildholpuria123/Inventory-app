import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/purchase_order_model.dart';

class PurchaseOrderPdfService {
  Future<String> generate(List<PurchaseOrderModel> orders) async {
    final pdf = pw.Document();

    final total = orders.fold<double>(0, (sum, e) => sum + e.estimatedCost);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Text(
              'PURCHASE ORDER',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Generated On : '
              '${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now())}',
            ),

            pw.SizedBox(height: 30),

            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: const [
                'Product',
                'Supplier',
                'Quantity',
                'Estimated Cost',
              ],
              data: orders.map((e) {
                return [
                  e.productName,
                  e.supplierName,
                  e.quantity.toString(),
                  '₹${e.estimatedCost.toStringAsFixed(2)}',
                ];
              }).toList(),
            ),

            pw.SizedBox(height: 30),

            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Container(
                width: 250,
                padding: const pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total Orders'),
                        pw.Text('${orders.length}'),
                      ],
                    ),

                    pw.SizedBox(height: 10),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Estimated Cost',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            pw.SizedBox(height: 40),

            pw.Center(child: pw.Text('Auto Generated Purchase Order')),
          ];
        },
      ),
    );

    final appDir = await getApplicationDocumentsDirectory();

    final folder = Directory(
      p.join(appDir.path, 'InventoryERP', 'PurchaseOrders'),
    );

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final fileName = 'PO_${DateTime.now().millisecondsSinceEpoch}.pdf';

    final file = File(p.join(folder.path, fileName));

    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(file.path);

    return file.path;
  }
}
