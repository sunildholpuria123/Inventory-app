import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class InvoiceItemSyncMapper
    implements BaseSyncMapper<InvoiceItem, InvoiceItemsCompanion> {
  @override
  Map<String, dynamic> toMap(
      InvoiceItem item,
      ) {
    return {
      'syncId': item.syncId,

      'invoiceId': item.invoiceId,

      'productId': item.productId,
      'productName': item.productName,

      'quantity': item.quantity,
      'price': item.price,
      // 'discount': item.d,
      // 'tax': item.taa,
      'total': item.total,

      'createdAt': item.createdAt.toIso8601String(),
      'updatedAt': item.updatedAt.toIso8601String(),
      'deletedAt': item.deletedAt?.toIso8601String(),
    };
  }

  @override
  InvoiceItemsCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return InvoiceItemsCompanion(
      syncId: Value(json['syncId']),

      invoiceId: Value(json['invoiceId']),

      productId: Value(json['productId']),
      productName: Value(json['productName']),

      quantity: Value(
        (json['quantity'] as num).toDouble() as int,
      ),

      price: Value(
        (json['price'] as num).toDouble(),
      ),

      // discount: Value(
      //   (json['discount'] as num).toDouble(),
      // ),
      //
      // tax: Value(
      //   (json['tax'] as num).toDouble(),
      // ),

      total: Value(
        (json['total'] as num).toDouble(),
      ),

      createdAt: Value(
        DateTime.parse(json['createdAt']),
      ),

      updatedAt: Value(
        DateTime.parse(json['updatedAt']),
      ),

      deletedAt: json['deletedAt'] == null
          ? const Value.absent()
          : Value(
        DateTime.parse(
          json['deletedAt'],
        ),
      ),
    );
  }
}