import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../model/invoice_item_model.dart';

class InvoicePdfService {
  Future<void> generateInvoice({
    required String invoiceNo,
    required String customerName,
    required String customerPhone,
    required List<InvoiceItemModel> items,
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(),
        ),

        build: (context) {
          return [
            _buildHeader(),

            pw.SizedBox(height: 20),

            _buildInvoiceInfo(
              invoiceNo: invoiceNo,
              customerName: customerName,
              customerPhone: customerPhone,
            ),

            pw.SizedBox(height: 25),

            _buildItemsTable(items),

            pw.SizedBox(height: 25),

            _buildSummary(
              subtotal: subtotal,
              tax: tax,
              discount: discount,
              grandTotal: grandTotal,
            ),

            pw.SizedBox(height: 40),

            _buildFooter(),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        return pdf.save();
      },
    );
  }

  pw.Widget _buildHeader() {
    return pw.Row(
      mainAxisAlignment:
      pw.MainAxisAlignment.spaceBetween,

      children: [
        pw.Column(
          crossAxisAlignment:
          pw.CrossAxisAlignment.start,

          children: [
            pw.Text(
              'INVENTORY ERP',
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight:
                pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 5),

            pw.Text(
              'Inventory Management System',
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),

            pw.SizedBox(height: 5),

            pw.Text(
              'support@inventoryerp.com',
            ),
          ],
        ),

        pw.Container(
          padding: const pw.EdgeInsets.all(12),

          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
            borderRadius:
            pw.BorderRadius.circular(8),
          ),

          child: pw.Text(
            'INVOICE',
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight:
              pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildInvoiceInfo({
    required String invoiceNo,
    required String customerName,
    required String customerPhone,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: PdfColors.grey300,
        ),
        borderRadius:
        pw.BorderRadius.circular(8),
      ),

      child: pw.Row(
        mainAxisAlignment:
        pw.MainAxisAlignment.spaceBetween,

        children: [
          pw.Column(
            crossAxisAlignment:
            pw.CrossAxisAlignment.start,

            children: [
              pw.Text(
                'Bill To',
                style: pw.TextStyle(
                  fontWeight:
                  pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Text(customerName),

              pw.Text(customerPhone),
            ],
          ),

          pw.Column(
            crossAxisAlignment:
            pw.CrossAxisAlignment.end,

            children: [
              pw.Text(
                'Invoice No',
                style: pw.TextStyle(
                  fontWeight:
                  pw.FontWeight.bold,
                ),
              ),

              pw.Text(invoiceNo),

              pw.SizedBox(height: 10),

              pw.Text(
                'Date',
                style: pw.TextStyle(
                  fontWeight:
                  pw.FontWeight.bold,
                ),
              ),

              pw.Text(
                DateFormat(
                  'dd MMM yyyy',
                ).format(DateTime.now()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildItemsTable(
      List<InvoiceItemModel> items,
      ) {
    return pw.Table(
      border: pw.TableBorder.all(
        color: PdfColors.grey300,
      ),

      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
      },

      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.grey200,
          ),

          children: [
            _tableHeader('Product'),
            _tableHeader('Qty'),
            _tableHeader('Price'),
            _tableHeader('Subtotal'),
          ],
        ),

        ...items.map(
              (item) {
            return pw.TableRow(
              children: [
                _tableCell(
                  item.name,
                ),

                _tableCell(
                  item.qty.toString(),
                ),

                _tableCell(
                  '₹${item.price.toStringAsFixed(2)}',
                ),

                _tableCell(
                  '₹${item.subtotal.toStringAsFixed(2)}',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  pw.Widget _tableHeader(
      String title,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),

      child: pw.Text(
        title,

        style: pw.TextStyle(
          fontWeight:
          pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _tableCell(
      String value,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),

      child: pw.Text(value),
    );
  }

  pw.Widget _buildSummary({
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
  }) {
    return pw.Align(
      alignment:
      pw.Alignment.centerRight,

      child: pw.Container(
        width: 250,

        padding: const pw.EdgeInsets.all(16),

        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.grey300,
          ),
          borderRadius:
          pw.BorderRadius.circular(8),
        ),

        child: pw.Column(
          children: [
            _summaryRow(
              'Subtotal',
              subtotal,
            ),

            pw.SizedBox(height: 8),

            _summaryRow(
              'GST',
              tax,
            ),

            pw.SizedBox(height: 8),

            _summaryRow(
              'Discount',
              discount,
            ),

            pw.Divider(),

            _summaryRow(
              'Grand Total',
              grandTotal,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _summaryRow(
      String title,
      double value, {
        bool isBold = false,
      }) {
    return pw.Row(
      mainAxisAlignment:
      pw.MainAxisAlignment.spaceBetween,

      children: [
        pw.Text(
          title,

          style: pw.TextStyle(
            fontWeight: isBold
                ? pw.FontWeight.bold
                : pw.FontWeight.normal,
          ),
        ),

        pw.Text(
          '₹${value.toStringAsFixed(2)}',

          style: pw.TextStyle(
            fontWeight: isBold
                ? pw.FontWeight.bold
                : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(),

        pw.SizedBox(height: 10),

        pw.Text(
          'Thank you for your business!',
          style: pw.TextStyle(
            fontWeight:
            pw.FontWeight.bold,
            fontSize: 16,
          ),
        ),

        pw.SizedBox(height: 10),

        pw.Text(
          'This is a computer generated invoice.',
          style: const pw.TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Future<Uint8List> generatePdfBytes({
    required String invoiceNo,
    required String customerName,
    required String customerPhone,
    required List<InvoiceItemModel> items,
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Text('Invoice'),
        ],
      ),
    );

    return pdf.save();
  }
}