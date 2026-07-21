import 'dart:io';

import 'package:intl/intl.dart' show DateFormat;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/database/app_database.dart';
import '../model/invoice_item_model.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:qr_flutter/qr_flutter.dart';

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
    required BusinessSetting businessSettings,
    required double loadingCharge,
    required double unloadingCharge,
    required double transportCharge,

    DateTime? dueDate,
  }) async {
    final pdf = pw.Document();
    final qrBytes = businessSettings.enableUpiPayment
        ? await _generateUpiQr(
            upiId: businessSettings.upiId!,
            merchant:
                businessSettings.upiMerchantName ??
                businessSettings.companyName,
            amount: grandTotal,
            invoiceNo: invoiceNo,
          )
        : null;
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          return [
            _buildHeader(invoiceNo, businessSettings),

            pw.SizedBox(height: 20),

            _buildCustomerSection(
              customerName,
              customerPhone,
              invoiceNo,
              paymentMethod,
              paymentStatus,
              dueDate,
            ),

            pw.SizedBox(height: 20),

            _buildItemsTable(items, businessSettings),

            pw.SizedBox(height: 20),

            _buildBottomSection(
              subtotal,
              tax,
              loadingCharge,
              unloadingCharge,
              transportCharge,
              discount,
              grandTotal,
              amountPaid,
              dueAmount,
              paymentMethod,
              paymentStatus,
              businessSettings,
              invoiceNo,
              qrBytes,
            ),

            pw.SizedBox(height: 25),

            _buildFooter(businessSettings),
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
          'Rs.${amount.toStringAsFixed(2)}',

          style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
        ),
      ],
    );
  }

  pw.Widget _buildHeader(String invoiceNo, BusinessSetting settings) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(18),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (settings.logoPath != null)
                  pw.Image(
                    pw.MemoryImage(File(settings.logoPath!).readAsBytesSync()),
                    width: 75,
                    height: 75,
                  ),

                pw.SizedBox(height: 10),

                pw.Text(
                  settings.companyName,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                if ((settings.address ?? "").isNotEmpty)
                  pw.Text(settings.address!),

                if ((settings.phone ?? "").isNotEmpty)
                  pw.Text("Phone : ${settings.phone}"),

                if ((settings.email ?? "").isNotEmpty)
                  pw.Text("Email : ${settings.email}"),

                if ((settings.gstNo ?? "").isNotEmpty)
                  pw.Text("GST : ${settings.gstNo}"),
              ],
            ),
          ),

          pw.Expanded(
            flex: 2,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Container(
                  color: PdfColors.grey300,
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    "TAX INVOICE",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                pw.SizedBox(height: 15),

                pw.Text(
                  "Invoice No",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                pw.Text(invoiceNo),

                pw.SizedBox(height: 10),

                pw.Text(DateFormat("dd MMM yyyy").format(DateTime.now())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCustomerSection(
    String customerName,
    String customerPhone,
    String invoiceNo,
    String paymentMethod,
    String paymentStatus,
    DateTime? dueDate,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// LEFT
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Bill To",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Divider(),

                pw.Text(
                  customerName,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                if (customerPhone.isNotEmpty) pw.Text(customerPhone),
              ],
            ),
          ),
        ),

        pw.SizedBox(width: 20),

        /// RIGHT
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Invoice Details",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Divider(),

                _buildInfoRow("Invoice No", invoiceNo),

                _buildInfoRow(
                  "Invoice Date",
                  DateFormat("dd MMM yyyy").format(DateTime.now()),
                ),

                _buildInfoRow("Payment", paymentMethod),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Status",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    _paymentStatusBadge(paymentStatus),
                  ],
                ),

                if (dueDate != null)
                  _buildInfoRow(
                    "Due Date",
                    DateFormat("dd MMM yyyy").format(dueDate),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildInfoRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

          pw.Text(value),
        ],
      ),
    );
  }

  pw.Widget _paymentStatusBadge(String status) {
    PdfColor color = PdfColors.orange;

    switch (status.toLowerCase()) {
      case "paid":
        color = PdfColors.green;
        break;

      case "due":
        color = PdfColors.red;
        break;

      case "partial":
        color = PdfColors.orange;
        break;
    }

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(3),
      ),
      child: pw.Text(
        status,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _buildItemsTable(
    List<InvoiceItemModel> items,
    BusinessSetting settings,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: .5),
      columnWidths: {
        0: const pw.FixedColumnWidth(25),
        1: const pw.FlexColumnWidth(4),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FixedColumnWidth(40),
        4: const pw.FixedColumnWidth(70),
        5: const pw.FixedColumnWidth(80),
      },
      children: [
        _tableHeader(),

        ...List.generate(
          items.length,
          (index) => _tableRow(index + 1, items[index], settings),
        ),
      ],
    );
  }

  pw.TableRow _tableHeader() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _headerCell("#"),

        _headerCell("Product"),

        _headerCell("Measurement"),

        _headerCell("Qty"),

        _headerCell("Rate"),

        _headerCell("Amount"),
      ],
    );
  }

  pw.Widget _headerCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
      ),
    );
  }

  pw.TableRow _tableRow(
    int index,
    InvoiceItemModel item,
    BusinessSetting settings,
  ) {
    final measurement = item.isAreaBased
        ? "${item.height?.toStringAsFixed(2)} × "
              "${item.width?.toStringAsFixed(2)}\n"
              "${(item.area! * item.qty).toStringAsFixed(2)} sqft"
        : "-";

    final productName = item.variantName == null
        ? item.product.name
        : "${item.product.name}\n${item.variantName}";

    return pw.TableRow(
      verticalAlignment: pw.TableCellVerticalAlignment.middle,
      children: [
        _tableCell(index.toString(), align: pw.TextAlign.center),

        _tableCell(productName),

        _tableCell(measurement),

        _tableCell(item.qty.toString(), align: pw.TextAlign.center),

        _tableCell(_currency(settings, item.price), align: pw.TextAlign.right),

        _tableCell(
          _currency(settings, item.total),
          align: pw.TextAlign.right,
          bold: true,
        ),
      ],
    );
  }

  pw.Widget _tableCell(
    String value, {
    pw.TextAlign align = pw.TextAlign.left,
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        value,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: bold ? pw.FontWeight.bold : null,
        ),
      ),
    );
  }

  String _currency(BusinessSetting settings, double amount) {
    final symbol = "Rs.";
    /*settings.currencySymbol ?? "₹"*/
    ;

    return "$symbol${amount.toStringAsFixed(2)}";
  }

  pw.Widget _buildBottomSection(
    double subtotal,
    double tax,
    double loading,
    double unloading,
    double transport,
    double discount,
    double grandTotal,
    double paid,
    double due,
    String paymentMethod,
    String paymentStatus,
    BusinessSetting settings,
    String invoiceNo,
    Uint8List? qrBytes,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 5,
          child: _buildBankCard(
            settings,
            amount: grandTotal,
            invoiceNo: invoiceNo,
            qrBytes: qrBytes,
          ),
        ),

        pw.SizedBox(width: 20),

        pw.Expanded(
          flex: 4,
          child: _buildAmountCard(
            subtotal,
            tax,
            loading,
            unloading,
            transport,
            discount,
            grandTotal,
            paid,
            due,
            paymentMethod,
            paymentStatus,
            settings,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildAmountCard(
    double subtotal,
    double tax,
    double loading,
    double unloading,
    double transport,
    double discount,
    double grandTotal,
    double paid,
    double due,
    String paymentMethod,
    String paymentStatus,
    BusinessSetting settings,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Column(
        children: [
          _amountRow("Subtotal", subtotal, settings),

          if (tax > 0) _amountRow("GST", tax, settings),

          if (loading > 0) _amountRow("Loading", loading, settings),

          if (unloading > 0) _amountRow("Unloading", unloading, settings),

          if (transport > 0) _amountRow("Transport", transport, settings),

          if (discount > 0) _amountRow("Discount", -discount, settings),

          pw.Divider(),

          _amountRow(
            "Grand Total",
            grandTotal,
            settings,
            bold: true,
            fontSize: 13,
          ),

          pw.SizedBox(height: 8),

          _amountRow("Paid", paid, settings),

          _amountRow("Due", due, settings, bold: due > 0),

          pw.Divider(),

          _infoLine("Payment", paymentMethod),
          _infoLine("Status", paymentStatus),
        ],
      ),
    );
  }

  pw.Widget _amountRow(
    String title,
    double value,
    BusinessSetting settings, {
    bool bold = false,
    double fontSize = 10,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : null,
              fontSize: fontSize,
            ),
          ),

          pw.Text(
            _currency(settings, value),
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : null,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _infoLine(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 4),
      child: pw.Row(
        children: [
          pw.Text(
            "$title : ",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),

          pw.Text(value),
        ],
      ),
    );
  }

  pw.Widget _buildBankCard(
    BusinessSetting settings, {
    required double amount,
    required String invoiceNo,
    required Uint8List? qrBytes,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Payment Details",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),

          pw.Divider(),

          if ((settings.bankName ?? "").isNotEmpty)
            pw.Text("Bank : ${settings.bankName}"),

          if ((settings.accountNumber ?? "").isNotEmpty)
            pw.Text("A/C No : ${settings.accountNumber}"),

          if ((settings.ifscCode ?? "").isNotEmpty)
            pw.Text("IFSC : ${settings.ifscCode}"),

          if ((settings.upiMerchantName ?? "").isNotEmpty)
            pw.Text("Merchant : ${settings.upiMerchantName}"),

          if ((settings.upiId ?? "").isNotEmpty)
            pw.Text("UPI ID : ${settings.upiId}"),

          pw.SizedBox(height: 15),

          if (settings.enableUpiPayment &&
              qrBytes != null &&
              qrBytes.isNotEmpty)
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(6),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey400),
                    ),
                    child: pw.Image(
                      pw.MemoryImage(qrBytes),
                      width: 110,
                      height: 110,
                    ),
                  ),

                  pw.SizedBox(height: 8),

                  pw.Text(
                    "Scan to Pay",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),

                  pw.SizedBox(height: 4),

                  pw.Text(
                    "Amount : ${_currency(settings, amount)}",
                    style: const pw.TextStyle(fontSize: 9),
                  ),

                  pw.Text(
                    "Invoice : $invoiceNo",
                    style: const pw.TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(BusinessSetting settings) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildTerms(),

        pw.SizedBox(height: 25),

        pw.Center(
          child: pw.Text(
            settings.footerMessage?.isNotEmpty == true
                ? settings.footerMessage!
                : "Thank you for your business!",
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ),

        pw.SizedBox(height: 30),

        _buildSignatureSection(settings),

        pw.SizedBox(height: 20),

        pw.Center(
          child: pw.Text(
            "This is a computer-generated invoice.",
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),

        pw.Center(
          child: pw.Text(
            "No physical signature is required.",
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),

        pw.SizedBox(height: 6),

        pw.Center(
          child: pw.Text(
            "Generated by Inventory ERP",
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTerms() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Terms & Conditions",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),

          pw.SizedBox(height: 8),

          pw.Bullet(text: "Goods once sold will not be taken back."),

          pw.Bullet(text: "Please verify goods before delivery."),

          pw.Bullet(text: "Payment should be made on or before the due date."),

          pw.Bullet(text: "Subject to local jurisdiction."),
        ],
      ),
    );
  }

  pw.Widget _buildSignatureSection(BusinessSetting settings) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        /// COMPANY STAMP
        pw.Column(
          children: [
            if (settings.stampPath != null)
              pw.Image(
                pw.MemoryImage(File(settings.stampPath!).readAsBytesSync()),
                width: 90,
                height: 90,
              )
            else
              pw.Container(
                width: 90,
                height: 90,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                ),
              ),

            pw.SizedBox(height: 8),

            pw.Text("Company Stamp", style: const pw.TextStyle(fontSize: 9)),
          ],
        ),

        /// SIGNATURE
        pw.Column(
          children: [
            if (settings.signaturePath != null)
              pw.Image(
                pw.MemoryImage(File(settings.signaturePath!).readAsBytesSync()),
                width: 120,
                height: 70,
              )
            else
              pw.Container(
                width: 120,
                height: 70,
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                  ),
                ),
              ),

            pw.SizedBox(height: 8),

            pw.Text(
              "Authorized Signature",
              style: const pw.TextStyle(fontSize: 9),
            ),
          ],
        ),
      ],
    );
  }

  Future<Uint8List> _generateUpiQr({
    required String upiId,
    required String merchant,
    required double amount,
    required String invoiceNo,
  }) async {
    final data =
        "upi://pay?"
        "pa=$upiId"
        "&pn=${Uri.encodeComponent(merchant)}"
        "&am=${amount.toStringAsFixed(2)}"
        "&cu=INR"
        "&tn=${Uri.encodeComponent("Invoice $invoiceNo")}";

    final painter = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: true,
    );

    final image = await painter.toImage(500);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }
}
