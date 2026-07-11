import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

class CustomerSyncMapper
    implements BaseSyncMapper<Customer, CustomersCompanion> {
  const CustomerSyncMapper();

  @override
  Map<String, dynamic> toMap(Customer customer, SyncExportContext context) {
    return {
      'id': customer.id,
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'address': customer.address,
      'creditBalance': customer.creditBalance,
      'createdAt': customer.createdAt.toIso8601String(),
      'updatedAt': customer.updatedAt.toIso8601String(),
      'syncId': customer.syncId,
      'deletedAt': customer.deletedAt?.toIso8601String(),
    };
  }

  @override
  CustomersCompanion toCompanion(
    Map<String, dynamic> json,
    SyncImportContext context,
  ) {
    return CustomersCompanion(
      id: Value(json['id']),

      name: Value(json['name'] ?? ''),

      phone: Value(json['phone'] ?? ''),

      email: Value(json['email']),

      address: Value(json['address']),

      creditBalance: Value((json['creditBalance'] as num?)?.toDouble() ?? 0),

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
