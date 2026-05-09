import '../../presentation/sales/model/invoice_item.dart';
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

  Future<void> saveInvoice({
    required int customerId,
    required List<InvoiceItem> items,
    required double total,
  }) async {
    await db.transaction(() async {
      final saleId =
      await db.createSale(
        SalesCompanion.insert(
          customerId: customerId,
          invoiceNo:
          'INV-${DateTime.now().millisecondsSinceEpoch}',
          total: total,
          discount: 0,
          tax: 0,
          grandTotal: total,
          paymentStatus: 'PAID',
        ),
      );

      for (final item in items) {
        await db.insertSaleItem(
          SaleItemsCompanion.insert(
            saleId: saleId,
            productId:
            item.product.id,
            qty: item.qty,
            price: item.price,
            subtotal:
            item.subtotal,
          ),
        );

        final updatedProduct =
        item.product.copyWith(
          stockQty:
          item.product.stockQty -
              item.qty,
        );

        await db.updateProduct(
          updatedProduct,
        );
      }
    });
  }
}