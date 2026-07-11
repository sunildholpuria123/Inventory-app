import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class ProductPriceHistoryRepository {
  final AppDatabase db;

  ProductPriceHistoryRepository(this.db);

  Future<void> addPriceHistory({
    required int productId,
    int? supplierId,
    required double oldPurchase,
    required double newPurchase,
    required double oldSelling,
    required double newSelling,
    String? remarks,
  }) async {
    final inflation = oldPurchase == 0
        ? 0
        : ((newPurchase - oldPurchase) / oldPurchase) * 100;

    await db
        .into(db.productPriceHistories)
        .insert(
          ProductPriceHistoriesCompanion.insert(
            productId: productId,

            supplierId: Value(supplierId),

            oldPurchasePrice: oldPurchase,

            newPurchasePrice: newPurchase,

            oldSellingPrice: oldSelling,

            newSellingPrice: newSelling,

            inflationPercentage: Value(inflation.toDouble()),

            remarks: Value(remarks),
          ),
        );
  }

  Future<List<ProductPriceHistory>> getPriceHistory(int productId) {
    return (db.select(db.productPriceHistories)
          ..where((tbl) => tbl.productId.equals(productId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.changedAt)]))
        .get();
  }

  Future<List<ProductPriceHistory>> getLatestInflations() {
    return (db.select(
      db.productPriceHistories,
    )..orderBy([(tbl) => OrderingTerm.desc(tbl.changedAt)])).get();
  }

  Future<List<ProductPriceHistory>> getProductPriceTrend(int productId) {
    return (db.select(db.productPriceHistories)
          ..where((tbl) => tbl.productId.equals(productId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.changedAt)]))
        .get();
  }

  Future<List<ProductPriceHistory>> getSupplierPriceTrend(int supplierId) {
    return (db.select(db.productPriceHistories)
          ..where((tbl) => tbl.supplierId.equals(supplierId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.changedAt)]))
        .get();
  }

  Future<List<ProductPriceHistory>> getInflationReport() {
    return (db.select(
      db.productPriceHistories,
    )..orderBy([(tbl) => OrderingTerm.desc(tbl.inflationPercentage)])).get();
  }
}
