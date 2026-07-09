import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class InvoiceSyncMapper
    implements BaseSyncMapper<Invoice, InvoicesCompanion> {
  @override
  Map<String, dynamic> toMap(Invoice invoice) {
    return {
      'syncId': invoice.syncId,

      'invoiceNo': invoice.invoiceNo,

      'customerId': invoice.customerId,
      'customerName': invoice.customerName,
      'customerPhone': invoice.customerPhone,

      'subtotal': invoice.subtotal,
      'discount': invoice.discount,
      'tax': invoice.tax,
      'grandTotal': invoice.grandTotal,

      'amountPaid': invoice.amountPaid,
      'dueAmount': invoice.dueAmount,

      'paymentStatus': invoice.paymentStatus,
      'paymentMethod': invoice.paymentMethod,

      // 'notes': invoice.notes,

      'createdAt': invoice.createdAt.toIso8601String(),
      'updatedAt': invoice.updatedAt.toIso8601String(),
      'deletedAt': invoice.deletedAt?.toIso8601String(),
    };
  }

  @override
  InvoicesCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return InvoicesCompanion(
      syncId: Value(json['syncId']),

      invoiceNo: Value(json['invoiceNo']),

      customerId: Value(json['customerId']),
      customerName: Value(json['customerName']),
      customerPhone: Value(json['customerPhone']),

      subtotal: Value(
        (json['subtotal'] as num).toDouble(),
      ),

      discount: Value(
        (json['discount'] as num).toDouble(),
      ),

      tax: Value(
        (json['tax'] as num).toDouble(),
      ),

      grandTotal: Value(
        (json['grandTotal'] as num).toDouble(),
      ),

      amountPaid: Value(
        (json['amountPaid'] as num).toDouble(),
      ),

      dueAmount: Value(
        (json['dueAmount'] as num).toDouble(),
      ),

      paymentStatus: Value(json['paymentStatus']),
      paymentMethod: Value(json['paymentMethod']),

      // notes: Value(json['notes']),

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