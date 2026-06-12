import 'package:drift/drift.dart';

import '../database/app_database.dart';

class ProductVariantRepository {
  final AppDatabase db;

  ProductVariantRepository(this.db);

  /// WATCH VARIANTS BY PRODUCT
  Stream<List<ProductVariant>> watchVariants(int productId) {
    return (db.select(db.productVariants)
          ..where(
            (tbl) =>
                tbl.productId.equals(productId) & tbl.isActive.equals(true),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.variantName)]))
        .watch();
  }

  /// ADD VARIANT
  Future<int> addVariant(ProductVariantsCompanion variant) {
    return db.into(db.productVariants).insert(variant);
  }

  /// UPDATE VARIANT
  Future<bool> updateVariant(ProductVariant variant) {
    return db.update(db.productVariants).replace(variant);
  }

  /// SOFT DELETE
  Future<void> deleteVariant(int id) async {
    await (db.update(db.productVariants)..where((tbl) => tbl.id.equals(id)))
        .write(const ProductVariantsCompanion(isActive: Value(false)));
  }
}
