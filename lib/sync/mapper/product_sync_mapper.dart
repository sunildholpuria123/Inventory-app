import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class ProductSyncMapper implements BaseSyncMapper<Product, ProductsCompanion> {
  const ProductSyncMapper();

  @override
  Map<String, dynamic> toMap(Product product) {
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
  ProductsCompanion toCompanion(Map<String, dynamic> json) {
    debugPrint("===== PRODUCT JSON =====");
    debugPrint(json.toString());
    debugPrint("========================");
    return ProductsCompanion(
      id: Value(json['id']),

      categoryId: Value(json['categoryId']),

      name: Value(json['name']),

      sku: Value(json['sku']),

      barcode: Value(json['barcode']),

      purchasePrice: Value((json['purchasePrice'] as num).toDouble()),

      sellingPrice: Value((json['sellingPrice'] as num).toDouble()),

      stockQty: Value(json['stockQty']),

      minStock: Value(json['minStock']),

      imagePath: Value(json['imagePath']),

      createdAt: Value(DateTime.parse(json['createdAt'])),

      updatedAt: Value(DateTime.parse(json['updatedAt'])),

      syncId: Value(json['syncId']),

      deletedAt: json['deletedAt'] == null
          ? const Value.absent()
          : Value(DateTime.parse(json['deletedAt'])),
    );
  }
}
