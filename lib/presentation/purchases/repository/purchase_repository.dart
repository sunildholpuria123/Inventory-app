import '../../../data/database/app_database.dart' hide PurchaseItem;
import '../../purchases/models/purchase_item.dart';

class PurchaseRepository {
  final AppDatabase db;

  PurchaseRepository(this.db);

  Future<void> savePurchase({
    required int supplierId,
    required List<PurchaseItem> items,
    required double total,
  }) async {
    await db.transaction(() async {
      final purchaseId =
      await db.into(db.purchases).insert(
        PurchasesCompanion.insert(
          supplierId: supplierId,
          total: total,
        ),
      );

      for (final item in items) {
        await db
            .into(db.purchaseItems)
            .insert(
          PurchaseItemsCompanion
              .insert(
            purchaseId:
            purchaseId,
            productId:
            item.product.id,
            qty: item.qty,
            price: item.price,
          ),
        );

        final updatedProduct =
        item.product.copyWith(
          stockQty:
          item.product.stockQty +
              item.qty,
        );

        await db.updateProduct(
          updatedProduct,
        );
      }
    });
  }
}