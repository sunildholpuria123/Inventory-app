import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

class PaymentSyncMapper
    implements BaseSyncMapper<PaymentHistory, PaymentHistoriesCompanion> {
  const PaymentSyncMapper();

  @override
  Map<String, dynamic> toMap(PaymentHistory payment,SyncExportContext context) {
    return {
      'id': payment.id,
      'invoiceId': payment.invoiceId,
      'customerId': payment.customerId,
      'amount': payment.amount,
      'paymentMethod': payment.paymentMethod,
      'notes': payment.notes,
      'paidAt': payment.paidAt.toIso8601String(),
      'createdAt': payment.createdAt.toIso8601String(),
      'updatedAt': payment.updatedAt.toIso8601String(),
      'syncId': payment.syncId,
      'deletedAt': payment.deletedAt?.toIso8601String(),
    };
  }

  @override
  PaymentHistoriesCompanion toCompanion(
      Map<String, dynamic> json,SyncImportContext context
      ) {
    return PaymentHistoriesCompanion(
      id: Value(json['id']),
      invoiceId: Value(json['invoiceId']),
      customerId: Value(json['customerId']),

      amount: Value(
        (json['amount'] as num?)?.toDouble() ?? 0,
      ),

      paymentMethod: Value(
        json['paymentMethod'] ?? 'Cash',
      ),

      notes: Value(json['notes']),

      paidAt: Value(
        json['paidAt'] != null
            ? DateTime.parse(json['paidAt'])
            : DateTime.now(),
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

      syncId: Value(
        json['syncId'] ?? '',
      ),

      deletedAt: Value(
        json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
      ),
    );
  }
}