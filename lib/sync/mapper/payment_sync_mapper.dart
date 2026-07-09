import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class PaymentSyncMapper
    implements BaseSyncMapper<PaymentHistory, PaymentHistoriesCompanion> {
  @override
  Map<String, dynamic> toMap(PaymentHistory payment) {
    return {
      'syncId': payment.syncId,

      'invoiceId': payment.invoiceId,
      'customerId': payment.customerId,

      'amount': payment.amount,

      'paymentMethod': payment.paymentMethod,

      // 'referenceNo': payment.referenceNo,

      'notes': payment.notes,

      'paidAt': payment.paidAt.toIso8601String(),

      'createdAt': payment.createdAt.toIso8601String(),
      'updatedAt': payment.updatedAt.toIso8601String(),
      'deletedAt': payment.deletedAt?.toIso8601String(),
    };
  }

  @override
  PaymentHistoriesCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return PaymentHistoriesCompanion(
      syncId: Value(json['syncId']),

      invoiceId: Value(json['invoiceId']),
      customerId: Value(json['customerId']),

      amount: Value(
        (json['amount'] as num).toDouble(),
      ),

      paymentMethod: Value(json['paymentMethod']),

      // referenceNo: Value(json['referenceNo']),

      notes: Value(json['notes']),

      paidAt: Value(
        DateTime.parse(json['paidAt']),
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