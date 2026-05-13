import 'package:drift/drift.dart';

import '../database/app_database.dart';

class SalesRepository {
  final AppDatabase db;

  SalesRepository(this.db);

  Future<void> createSale({
    required int customerId,
    required double total,
  }) async {
    await db.createSale(
      SalesCompanion.insert(
        customerId: customerId,
        invoiceNo: 'INV-${DateTime.now().millisecondsSinceEpoch}',
        total: total,
        discount: 0,
        tax: 0,
        grandTotal: total,
        paymentStatus: 'PAID',
      ),
    );
  }

  Future<int> saveInvoice({
    required String customerName,
    required String customerPhone,
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
    required String paymentMethod,
    required String pdfPath,
  }) async {
    final invoiceNo =
        'INV-${DateTime.now().year}'
        '${DateTime.now().month.toString().padLeft(2, '0')}'
        '${DateTime.now().day.toString().padLeft(2, '0')}-'
        '${DateTime.now().millisecondsSinceEpoch}';

    final invoiceId = await db
        .into(db.invoices)
        .insert(
          InvoicesCompanion.insert(
            invoiceNo: invoiceNo,

            customerName: customerName,

            customerPhone: customerPhone,

            subtotal: subtotal,

            tax: tax,

            discount: Value(discount),

            grandTotal: grandTotal,

            paymentMethod: Value(paymentMethod),

            pdfPath: Value(pdfPath),
          ),
        );

    return invoiceId;
  }
}
