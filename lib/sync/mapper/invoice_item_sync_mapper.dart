import 'package:drift/drift.dart';
import 'package:inventory_desktop/sync/context/sync_export_context.dart';
import 'package:inventory_desktop/sync/context/sync_import_context.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';


class InvoiceItemSyncMapper
    implements BaseSyncMapper<InvoiceItem, InvoiceItemsCompanion> {
  const InvoiceItemSyncMapper();

  @override
  InvoiceItemsCompanion toCompanion(Map<String, dynamic> json, SyncImportContext context) {
    return InvoiceItemsCompanion(
      id: Value(json['id']),
      invoiceId: Value(json['invoiceId']),
      productId: Value(json['productId']),
      variantId: Value(json['variantId']),
      productName: Value(json['productName'] ?? ''),
      variantName: Value(json['variantName']),
      quantity: Value(json['quantity'] ?? 0),

      price: Value(
        (json['price'] as num?)?.toDouble() ?? 0,
      ),

      height: Value(
        (json['height'] as num?)?.toDouble(),
      ),

      width: Value(
        (json['width'] as num?)?.toDouble(),
      ),

      area: Value(
        (json['area'] as num?)?.toDouble(),
      ),

      total: Value(
        (json['total'] as num?)?.toDouble() ?? 0,
      ),

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
        json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
      ),
    );
  }

  @override
  Map<String, dynamic> toMap(InvoiceItem item, SyncExportContext context) {
    return {
      'id': item.id,
      'invoiceId': item.invoiceId,
      'productId': item.productId,
      'variantId': item.variantId,
      'productName': item.productName,
      'variantName': item.variantName,
      'quantity': item.quantity,
      'price': item.price,
      'height': item.height,
      'width': item.width,
      'area': item.area,
      'total': item.total,
      'createdAt': item.createdAt.toIso8601String(),
      'updatedAt': item.updatedAt.toIso8601String(),
      'syncId': item.syncId,
      'deletedAt': item.deletedAt?.toIso8601String(),
    };
  }

}