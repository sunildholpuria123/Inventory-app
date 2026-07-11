import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class InvoiceSyncMapper implements BaseSyncMapper<Invoice, InvoicesCompanion> {
  const InvoiceSyncMapper();

  @override
  Map<String, dynamic> toMap(Invoice invoice, SyncExportContext context) {
    return {
      'id': invoice.id,
      'invoiceNo': invoice.invoiceNo,
      'customerName': invoice.customerName,
      'customerPhone': invoice.customerPhone,
      'subtotal': invoice.subtotal,
      'tax': invoice.tax,
      'discount': invoice.discount,
      'grandTotal': invoice.grandTotal,
      'paymentMethod': invoice.paymentMethod,
      'paymentStatus': invoice.paymentStatus,
      'amountPaid': invoice.amountPaid,
      'dueAmount': invoice.dueAmount,
      'dueDate': invoice.dueDate?.toIso8601String(),
      'reminderSent': invoice.reminderSent,
      'loadingCharge': invoice.loadingCharge,
      'unloadingCharge': invoice.unloadingCharge,
      'transportCharge': invoice.transportCharge,
      'customerId': invoice.customerId,
      'pdfPath': invoice.pdfPath,
      'createdAt': invoice.createdAt.toIso8601String(),
      'updatedAt': invoice.updatedAt.toIso8601String(),
      'syncId': invoice.syncId,
      'deletedAt': invoice.deletedAt?.toIso8601String(),
    };
  }

  @override
  InvoicesCompanion toCompanion(
    Map<String, dynamic> json,
      SyncImportContext context,
  ) {
    return InvoicesCompanion(
      id: Value(json['id']),
      invoiceNo: Value(json['invoiceNo'] ?? ''),
      customerName: Value(json['customerName'] ?? ''),
      customerPhone: Value(json['customerPhone'] ?? ''),

      subtotal: Value((json['subtotal'] as num?)?.toDouble() ?? 0),

      tax: Value((json['tax'] as num?)?.toDouble() ?? 0),

      discount: Value((json['discount'] as num?)?.toDouble() ?? 0),

      grandTotal: Value((json['grandTotal'] as num?)?.toDouble() ?? 0),

      paymentMethod: Value(json['paymentMethod'] ?? 'CASH'),

      paymentStatus: Value(json['paymentStatus'] ?? 'PAID'),

      amountPaid: Value((json['amountPaid'] as num?)?.toDouble() ?? 0),

      dueAmount: Value((json['dueAmount'] as num?)?.toDouble() ?? 0),

      dueDate: Value(
        json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      ),

      reminderSent: Value(json['reminderSent'] ?? false),

      loadingCharge: Value((json['loadingCharge'] as num?)?.toDouble() ?? 0),

      unloadingCharge: Value(
        (json['unloadingCharge'] as num?)?.toDouble() ?? 0,
      ),

      transportCharge: Value(
        (json['transportCharge'] as num?)?.toDouble() ?? 0,
      ),

      customerId: Value(json['customerId']),

      pdfPath: Value(json['pdfPath']),

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
