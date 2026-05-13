import 'package:drift/drift.dart';

import '../database/app_database.dart';

class ProductRepository {
  final AppDatabase db;

  ProductRepository(this.db);

  Stream<List<Product>> watchProducts() {
    return db.watchProducts();
  }

  Future<void> addProduct({
    required String name,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQty,
    String? barcode,
    String? imagePath,
  }) async {
    await db.insertProduct(
      ProductsCompanion.insert(
        categoryId: 1,
        name: name,
        purchasePrice: purchasePrice,
        sellingPrice: sellingPrice,
        stockQty: stockQty,
        minStock: 5,

        barcode: Value(barcode),

        imagePath: Value(imagePath),
      ),
    );
  }

  Future<void> deleteProduct(
      int id,
      ) async {
    await db.deleteProduct(id);
  }

  Future<void> updateProductData({
    required Product product,
  }) async {
    await db.updateProduct(product);
  }

  /// REDUCE STOCK AFTER SALES
  Future<void> reduceStock({
    required int productId,
    required int qty,
  }) async {
    final product =
    await (db.select(
      db.products,
    )..where(
          (tbl) =>
          tbl.id.equals(
            productId,
          ),
    ))
        .getSingle();

    /// PREVENT NEGATIVE STOCK
    if (product.stockQty < qty) {
      throw Exception(
        'Insufficient stock for ${product.name}',
      );
    }

    await (db.update(
      db.products,
    )..where(
          (tbl) =>
          tbl.id.equals(
            productId,
          ),
    ))
        .write(
      ProductsCompanion(
        stockQty: Value(
          product.stockQty - qty,
        ),
      ),
    );
  }

  /// INCREASE STOCK AFTER PURCHASE
  Future<void> increaseStock({
    required int productId,
    required int qty,
  }) async {
    final product =
    await (db.select(
      db.products,
    )..where(
          (tbl) =>
          tbl.id.equals(
            productId,
          ),
    ))
        .getSingle();

    await (db.update(
      db.products,
    )..where(
          (tbl) =>
          tbl.id.equals(
            productId,
          ),
    ))
        .write(
      ProductsCompanion(
        stockQty: Value(
          product.stockQty + qty,
        ),
      ),
    );
  }
}

