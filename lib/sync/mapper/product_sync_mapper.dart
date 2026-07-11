import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

class ProductSyncMapper implements BaseSyncMapper<Product, ProductsCompanion> {
  const ProductSyncMapper();

  @override
  Map<String, dynamic> toMap(Product product, SyncExportContext context) {
    return {
      'id': product.id,
      'categoryId': product.categoryId,
      'name': product.name,
      'sku': product.sku,
      'barcode': product.barcode,
      'purchasePrice': product.purchasePrice,
      'sellingPrice': product.sellingPrice,
      'stockQty': product.stockQty,
      'minStock': product.minStock,
      'imagePath': product.imagePath,
      'createdAt': product.createdAt.toIso8601String(),
      'updatedAt': product.updatedAt.toIso8601String(),
      'syncId': product.syncId,
      'deletedAt': product.deletedAt?.toIso8601String(),
    };
  }

  @override
  ProductsCompanion toCompanion(Map<String, dynamic> json,SyncImportContext context) {
    return ProductsCompanion(
      id: Value(json['id']),

      categoryId: Value(json['categoryId'] ?? 0),

      name: Value(json['name'] ?? ''),

      sku: Value(json['sku']),

      barcode: Value(json['barcode']),

      purchasePrice: Value((json['purchasePrice'] as num?)?.toDouble() ?? 0),

      sellingPrice: Value((json['sellingPrice'] as num?)?.toDouble() ?? 0),

      stockQty: Value(json['stockQty'] ?? 0),

      minStock: Value(json['minStock'] ?? 0),

      imagePath: Value(json['imagePath']),

      createdAt: Value(
        json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
      ),

      updatedAt: Value(
        json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
      ),

      syncId: Value(json['syncId'] ?? ''),

      deletedAt: Value(
        json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      ),
    );
  }
}
