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
    required int customerId,
    required String customerName,
    required String customerPhone,
    required double subtotal,
    required double tax,
    required double discount,
    required double grandTotal,
    required String paymentMethod,
    required double amountPaid,
    DateTime? dueDate,
    required String pdfPath,
  }) async {
    final invoiceNo =
        'INV-${DateTime.now().year}'
        '${DateTime.now().month.toString().padLeft(2, '0')}'
        '${DateTime.now().day.toString().padLeft(2, '0')}-'
        '${DateTime.now().millisecondsSinceEpoch}';
    final dueAmount = grandTotal - amountPaid;

    final paymentStatus = dueAmount <= 0
        ? 'PAID'
        : amountPaid == 0
        ? 'CREDIT'
        : 'PARTIAL';

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

            paymentStatus: Value(paymentStatus),

            amountPaid: Value(amountPaid),

            dueAmount: Value(dueAmount),

            dueDate: Value(dueDate),

            pdfPath: Value(pdfPath),
          ),
        );
    if (dueAmount > 0) {
      final customer = await (db.select(
        db.customers,
      )..where((tbl) => tbl.id.equals(customerId))).getSingle();

      await (db.update(
        db.customers,
      )..where((tbl) => tbl.id.equals(customerId))).write(
        CustomersCompanion(
          creditBalance: Value(customer.creditBalance + dueAmount),
        ),
      );
    }

    return invoiceId;
  }

  /// GET INVOICES
  Future<List<Invoice>> getInvoices({String search = ''}) async {
    final query = db.select(db.invoices);

    if (search.isNotEmpty) {
      query.where(
        (tbl) =>
            tbl.customerName.like('%$search%') |
            tbl.invoiceNo.like('%$search%'),
      );
    }

    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
    ]);

    return query.get();
  }

  /// DELETE INVOICE
  Future<void> deleteInvoice(int invoiceId) async {
    /// DELETE ITEMS
    await (db.delete(
      db.invoiceItems,
    )..where((tbl) => tbl.invoiceId.equals(invoiceId))).go();

    /// DELETE INVOICE
    await (db.delete(
      db.invoices,
    )..where((tbl) => tbl.id.equals(invoiceId))).go();
  }

  Future<void> restoreStockFromInvoice(int invoiceId) async {
    final items = await (db.select(
      db.invoiceItems,
    )..where((tbl) => tbl.invoiceId.equals(invoiceId))).get();

    for (final item in items) {
      final product = await (db.select(
        db.products,
      )..where((tbl) => tbl.id.equals(item.productId))).getSingle();

      await (db.update(
        db.products,
      )..where((tbl) => tbl.id.equals(item.productId))).write(
        ProductsCompanion(stockQty: Value(product.stockQty + item.quantity)),
      );
    }
  }
}
