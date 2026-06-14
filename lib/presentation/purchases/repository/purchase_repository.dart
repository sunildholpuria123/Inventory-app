import 'package:drift/drift.dart' show Value, OrderingTerm, OrderingMode;

import '../../../data/database/app_database.dart';
import '../models/purchase_item.dart';

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
    final purchaseNo = 'PUR-${DateTime.now().millisecondsSinceEpoch}';

    final purchaseId = await db
        .into(db.purchases)
        .insert(
          PurchasesCompanion.insert(
            purchaseNo: purchaseNo,

            supplierName: supplierName,

            supplierPhone: Value(supplierPhone),

            total: total,

            pdfPath: Value(pdfPath),
          ),
        );

    return purchaseId;
  }

  /// SAVE PURCHASE ITEMS
  Future<void> savePurchaseItems({
    required int purchaseId,
    required List<PurchaseCartItem> items,
  }) async {
    for (final item in items) {
      await db
          .into(db.purchaseItems)
          .insert(
            PurchaseItemsCompanion.insert(
              purchaseId: purchaseId,

              productId: item.product.id,

              variantId: Value(item.variant?.id),

              productName: item.product.name,

              variantName: Value(item.variant?.variantName),

              quantity: item.qty,

              purchasePrice: item.price,

              total: item.total,
            ),
          );
    }
  }

  /// PURCHASE HISTORY
  Future<List<Purchase>> getPurchases() async {
    return (db.select(db.purchases)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
        ]))
        .get();
  }

  /// DELETE PURCHASE
  Future<void> deletePurchase(int purchaseId) async {
    await (db.delete(
      db.purchaseItems,
    )..where((tbl) => tbl.purchaseId.equals(purchaseId))).go();

    await (db.delete(
      db.purchases,
    )..where((tbl) => tbl.id.equals(purchaseId))).go();
  }

  Future<List<PurchaseItem>> getPurchaseItems(int purchaseId) {
    return (db.select(
      db.purchaseItems,
    )..where((tbl) => tbl.purchaseId.equals(purchaseId))).get();
  }

  Stream<double> watchTotalPurchases() {
    return db
        .customSelect('''
    SELECT
    COALESCE(
      SUM(total),
      0
    ) total
    FROM purchases
    ''')
        .watch()
        .map((rows) {
          return (rows.first.data['total'] as num?)?.toDouble() ?? 0;
        });
  }

  Stream<Map<String, double>> watchPurchasesBySupplier() {
    return db
        .customSelect('''
    SELECT
      supplier_name,
      SUM(total) total
    FROM purchases
    GROUP BY supplier_name
    ''')
        .watch()
        .map((rows) {
          return {
            for (final row in rows)
              row.data['supplier_name'].toString(): (row.data['total'] as num)
                  .toDouble(),
          };
        });
  }

  Future<void> createPurchaseReturn({
    required int purchaseId,
    required int supplierId,
    required int productId,
    int? variantId,
    required int quantity,
    required double amount,
    required String reason,
    String? notes,
  }) async {
    await db
        .into(db.purchaseReturns)
        .insert(
          PurchaseReturnsCompanion.insert(
            purchaseId: purchaseId,

            supplierId: supplierId,

            productId: productId,

            variantId: Value(variantId),

            quantity: quantity,

            amount: amount,

            reason: reason,

            notes: Value(notes),
          ),
        );
  }

  Future<void> processPurchaseReturn({
    required PurchaseReturn returnItem,
  }) async {
    if (returnItem.variantId != null) {
      final variant = await (db.select(
        db.productVariants,
      )..where((tbl) => tbl.id.equals(returnItem.variantId!))).getSingle();

      await db
          .update(db.productVariants)
          .replace(
            variant.copyWith(stockQty: variant.stockQty - returnItem.quantity),
          );
    } else {
      final product = await (db.select(
        db.products,
      )..where((tbl) => tbl.id.equals(returnItem.productId))).getSingle();

      await db
          .update(db.products)
          .replace(
            product.copyWith(stockQty: product.stockQty - returnItem.quantity),
          );
    }
  }

  Future<void> applyDebitNote({
    required int supplierId,
    required double amount,
  }) async {

    final supplier =
    await (db.select(
      db.suppliers,
    )
      ..where(
            (tbl) =>
            tbl.id.equals(
              supplierId,
            ),
      ))
        .getSingle();

    await (db.update(
      db.suppliers,
    )
      ..where(
            (tbl) =>
            tbl.id.equals(
              supplierId,
            ),
      ))
        .write(

      SuppliersCompanion(

        creditBalance:
        Value(

          supplier.creditBalance -
              amount,
        ),
      ),
    );
  }

  Future<void> markRefundReceived(
      int returnId,
      ) async {

    await (db.update(
      db.purchaseReturns,
    )
      ..where(
            (tbl) =>
            tbl.id.equals(
              returnId,
            ),
      ))
        .write(

      const PurchaseReturnsCompanion(

        refundStatus:
        Value(
          'RECEIVED',
        ),
      ),
    );
  }

  Stream<List<PurchaseReturn>>
  watchPurchaseReturns() {

    return (db.select(
      db.purchaseReturns,
    )
      ..orderBy([
            (tbl) =>
            OrderingTerm.desc(
              tbl.createdAt,
            ),
      ]))
        .watch();
  }

  Stream<List<PurchaseReturn>>
  watchSupplierReturns(
      int supplierId,
      ) {

    return (db.select(
      db.purchaseReturns,
    )
      ..where(
            (tbl) =>
            tbl.supplierId.equals(
              supplierId,
            ),
      ))
        .watch();
  }

  Stream<double>
  watchTotalPurchaseReturns() {

    return db.customSelect(
      '''
    SELECT
    COALESCE(
      SUM(amount),
      0
    ) total
    FROM purchase_returns
    ''',
    ).watch().map(
          (rows) {

        return (rows.first
            .data[
        'total']
        as num?)
            ?.toDouble() ??
            0;
      },
    );
  }

  Stream<double>
  watchPendingRefunds() {

    return db.customSelect(
      '''
    SELECT
    COALESCE(
      SUM(amount),
      0
    ) total
    FROM purchase_returns
    WHERE refund_status =
    'PENDING'
    ''',
    ).watch().map(
          (rows) {

        return (rows.first
            .data[
        'total']
        as num?)
            ?.toDouble() ??
            0;
      },
    );
  }
}
