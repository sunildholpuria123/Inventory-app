import '../../presentation/sales/model/cart_item.dart'
    show CartItem;

import '../database/app_database.dart';

class InvoiceItemRepository {
  final AppDatabase db;

  InvoiceItemRepository(this.db);

  Future<void> saveInvoiceItems({
    required int invoiceId,
    required List<CartItem> items,
  }) async {
    for (final item in items) {
      await db.into(
        db.invoiceItems,
      ).insert(
        InvoiceItemsCompanion.insert(
          invoiceId: invoiceId,

          productId:
          item.product.id,

          productName:
          item.product.name,

          quantity: item.qty,

          price: item.price,

          total: item.total,
        ),
      );
    }
  }

  Future<List<InvoiceItem>>
  getItemsByInvoice(
      int invoiceId,
      ) async {
    final result =
    await (db.select(
      db.invoiceItems,
    )..where(
          (tbl) =>
          tbl.invoiceId.equals(
            invoiceId,
          ),
    ))
        .get();

    return result;
  }
}