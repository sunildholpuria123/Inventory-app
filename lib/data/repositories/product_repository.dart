import 'package:drift/drift.dart'
    show Value, ComparableExpr, StringExpressionOperators, OrderingTerm;

import '../../core/services/product_image_service.dart'
    show ProductImageService;
import '../database/app_database.dart';

class ProductRepository {
  final AppDatabase db;

  ProductRepository(this.db);

  /// GET ALL PRODUCTS
  Stream<List<Product>> watchProducts({String search = '', int? categoryId}) {
    final query = db.select(db.products);

    if (search.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$search%'));
    }

    if (categoryId != null) {
      query.where((tbl) => tbl.categoryId.equals(categoryId));
    }

    query.orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);

    return query.watch();
  }

  /// ADD PRODUCT
  Future<void> addProduct({
    required int categoryId,
    required String name,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQty,
    String? barcode,
    String? imagePath,
  }) async {
    await db.insertProduct(
      ProductsCompanion.insert(
        categoryId: categoryId,

        name: name.trim(),

        purchasePrice: purchasePrice,

        sellingPrice: sellingPrice,

        stockQty: stockQty,

        minStock: 5,

        barcode: Value(
          barcode?.trim().isEmpty == true ? null : barcode?.trim(),
        ),

        imagePath: Value(imagePath?.trim().isEmpty == true ? null : imagePath),
      ),
    );
  }

  /// UPDATE PRODUCT
  Future<void> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQty,
    String? barcode,
    String? imagePath,
  }) async {
    await (db.update(db.products)..where((tbl) => tbl.id.equals(id))).write(
      ProductsCompanion(
        name: Value(name.trim()),
        categoryId: Value(categoryId),
        purchasePrice: Value(purchasePrice),

        sellingPrice: Value(sellingPrice),

        stockQty: Value(stockQty),

        barcode: Value(
          barcode?.trim().isEmpty == true ? null : barcode?.trim(),
        ),

        imagePath: Value(imagePath?.trim().isEmpty == true ? null : imagePath),
      ),
    );
  }

  /// DELETE PRODUCT
  Future<void> deleteProduct(Product product) async {
    /// DELETE IMAGE
    await ProductImageService.deleteImage(product.imagePath);

    await (db.delete(
      db.products,
    )..where((tbl) => tbl.id.equals(product.id))).go();
  }

  /// REDUCE STOCK AFTER SALES
  Future<void> reduceStock({required int productId, required int qty}) async {
    final product = await (db.select(
      db.products,
    )..where((tbl) => tbl.id.equals(productId))).getSingle();

    /// PREVENT NEGATIVE STOCK
    if (product.stockQty < qty) {
      throw Exception('Insufficient stock for ${product.name}');
    }

    await (db.update(db.products)..where((tbl) => tbl.id.equals(productId)))
        .write(ProductsCompanion(stockQty: Value(product.stockQty - qty)));
  }

  /// INCREASE STOCK AFTER PURCHASE
  Future<void> increaseStock({required int productId, required int qty}) async {
    final product = await (db.select(
      db.products,
    )..where((tbl) => tbl.id.equals(productId))).getSingle();

    await (db.update(db.products)..where((tbl) => tbl.id.equals(productId)))
        .write(ProductsCompanion(stockQty: Value(product.stockQty + qty)));
  }

  /// LOW STOCK PRODUCTS
  Stream<List<Product>> watchLowStockProducts() {
    return (db.select(
      db.products,
    )..where((tbl) => tbl.stockQty.isSmallerOrEqualValue(5))).watch();
  }

  /// TOTAL PRODUCT COUNT
  Future<int> getProductCount() async {
    final products = await db.select(db.products).get();

    return products.length;
  }

  /// SEARCH PRODUCTS
  Future<List<Product>> searchProducts(String query) async {
    return (db.select(
      db.products,
    )..where((tbl) => tbl.name.like('%$query%'))).get();
  }

  /// GET PRODUCT BY ID
  Future<Product?> getProductById(int id) async {
    final result = await (db.select(
      db.products,
    )..where((tbl) => tbl.id.equals(id))).get();

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  /// TOP SELLING PRODUCTS
  Future<List<Map<String, dynamic>>> getTopSellingProducts() async {
    final result = await db.customSelect('''
      SELECT 
      product_name,
      SUM(quantity) as total_qty
      FROM invoice_items
      GROUP BY product_name
      ORDER BY total_qty DESC
      LIMIT 5
      ''').get();

    return result.map((e) => e.data).toList();
  }
}
