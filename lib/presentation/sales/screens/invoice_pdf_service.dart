import 'dart:io';

import 'package:intl/intl.dart' show DateFormat;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/invoice_item_model.dart';

class InvoicePdfService {
  Future<String> generateInvoice({
    required String invoiceNo,
    required String customerName,
    required String customerPhone,
    required List<InvoiceItemModel> items,
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
    required String paymentMethod,

    required double amountPaid,
    required double dueAmount,
    required String paymentStatus,

    DateTime? dueDate,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,

                  children: [
                    pw.Text(
                      'INVOICE',

                      style: pw.TextStyle(
                        fontSize: 28,

                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    pw.Text('Invoice No: $invoiceNo'),

                    pw.Text(
                      'Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                    ),
                  ],
                ),

                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),

                  data: invoiceNo,

                  width: 80,
                  height: 80,
                ),
              ],
            ),

            pw.SizedBox(height: 30),

            pw.Container(
              padding: const pw.EdgeInsets.all(15),

              decoration: pw.BoxDecoration(border: pw.Border.all()),

              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,

                children: [
                  pw.Text(
                    'Customer Details',

                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),

                  pw.SizedBox(height: 10),

                  pw.Text('Name: $customerName'),

                  pw.Text('Phone: $customerPhone'),
                ],
              ),
            ),

            pw.SizedBox(height: 30),

            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),

              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),

              cellStyle: const pw.TextStyle(fontSize: 10),

              headers: ['Product', 'Qty', 'Rate/Sqft', 'Measurement', 'Total'],
              data: items.map((e) {
                final productName = e.variantName != null
                    ? '${e.product.name}\n'
                          '(${e.variantName})'
                    : e.product.name;

                final areaText = e.isAreaBased
                    ? '${e.height?.toStringAsFixed(2)} × '
                          '${e.width?.toStringAsFixed(2)}'
                          ' × ${e.qty}\n'
                          '= ${(e.area! * e.qty).toStringAsFixed(2)} sqft'
                    : '-';

                return [
                  productName,

                  e.isAreaBased ? '${e.qty} Slab' : e.qty.toString(),
                  '₹${e.price.toStringAsFixed(2)}',

                  areaText,

                  '₹${e.total.toStringAsFixed(2)}',
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
                    buildAmountRow('Subtotal', subtotal),

                    pw.SizedBox(height: 8),

                    buildAmountRow('Tax', tax),

                    pw.SizedBox(height: 8),

                    buildAmountRow('Discount', discount),

                    pw.Divider(),

                    buildAmountRow('Grand Total', grandTotal, bold: true),
                    buildAmountRow('Amount Paid', amountPaid),
                    buildAmountRow('Due Amount', dueAmount),

                    pw.Text(
                      'Payment Details',

                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    pw.Text('Payment Method: $paymentMethod'),

                    pw.Text('Payment Status: $paymentStatus'),
                    if (dueDate != null)
                      pw.Text(
                        'Due Date: ${DateFormat('dd MMM yyyy').format(dueDate)}',
                      ),
                  ],
                ),
              ),
            ),

            pw.SizedBox(height: 40),

            pw.Center(child: pw.Text('Thank you for your business!')),
          ];
        },
      ),
    );

    /// APP DIRECTORY
    final appDir = await getApplicationDocumentsDirectory();

    /// ERP INVOICE DIRECTORY
    final invoiceFolder = Directory(
      p.join(appDir.path, 'InventoryERP', 'Invoices'),
    );

    /// CREATE DIRECTORY
    if (!await invoiceFolder.exists()) {
      await invoiceFolder.create(recursive: true);
    }

    /// SAFE FILE NAME
    final safeCustomerName = customerName
        .replaceAll(RegExp(r'[^\w\s]+'), '')
        .replaceAll(' ', '_');

    final fileName = '${invoiceNo}_$safeCustomerName.pdf';

    final file = File(p.join(invoiceFolder.path, fileName));

    /// SAVE PDF
    await file.writeAsBytes(await pdf.save());

    /// AUTO OPEN PDF
    await OpenFilex.open(file.path);

    print('Invoice Saved: ${file.path}');

    return file.path;
  }

  pw.Widget buildAmountRow(String title, double amount, {bool bold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

      children: [
        pw.Text(
          title,

          style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
        ),

        pw.Text(
          '₹${amount.toStringAsFixed(2)}',

          style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
        ),
      ],
    );
  }
}
