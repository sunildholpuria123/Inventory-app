import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode;

import '../../../data/database/app_database.dart' show AppDatabase, PurchasesCompanion, PurchaseItemsCompanion, Purchase;

class PurchaseRepository {
  final AppDatabase db;

  PurchaseRepository(this.db);

  /// SAVE PURCHASE
  Future<int> savePurchase({
    required String supplierName,
    required String supplierPhone,
    required double total,
    String? pdfPath,
  }) async {
    final purchaseNo =
        'PUR-${DateTime.now().millisecondsSinceEpoch}';

    final purchaseId =
    await db.into(
      db.purchases,
    ).insert(
      PurchasesCompanion.insert(
        purchaseNo: purchaseNo,

        supplierName:
        supplierName,

        supplierPhone:
        Value(
          supplierPhone,
        ),

        total: total,

        pdfPath:
        Value(pdfPath),
      ),
    );

    return purchaseId;
  }

  /// SAVE PURCHASE ITEMS
  Future<void>
  savePurchaseItems({
    required int purchaseId,
    required List<dynamic> items,
  }) async {
    for (final item in items) {
      await db.into(
        db.purchaseItems,
      ).insert(
        PurchaseItemsCompanion.insert(
          purchaseId: purchaseId,

          productId:
          item.product.id,

          productName:
          item.product.name,

          quantity:
          item.qty,

          purchasePrice:
          item.price,

          total:
          item.total,
        ),
      );
    }
  }

  /// PURCHASE HISTORY
  Future<List<Purchase>>
  getPurchases() async {
    return (db.select(
      db.purchases,
    )..orderBy([
          (tbl) => OrderingTerm(
        expression:
        tbl.createdAt,

        mode:
        OrderingMode.desc,
      ),
    ]))
        .get();
  }

  /// DELETE PURCHASE
  Future<void> deletePurchase(
      int purchaseId,
      ) async {
    await (db.delete(
      db.purchaseItems,
    )..where(
          (tbl) =>
          tbl.purchaseId.equals(
            purchaseId,
          ),
    ))
        .go();

    await (db.delete(
      db.purchases,
    )..where(
          (tbl) =>
          tbl.id.equals(
            purchaseId,
          ),
    ))
        .go();
  }
}