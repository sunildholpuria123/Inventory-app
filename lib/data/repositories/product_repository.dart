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
  }) async {
    await db.insertProduct(
      ProductsCompanion.insert(
        categoryId: 1,
        name: name,
        purchasePrice: purchasePrice,
        sellingPrice: sellingPrice,
        stockQty: stockQty,
        minStock: 5,
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
}

