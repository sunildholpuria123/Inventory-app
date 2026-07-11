import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class SupplierSyncMapper
    implements BaseSyncMapper<Supplier, SuppliersCompanion> {
  const SupplierSyncMapper();

  @override
  Map<String, dynamic> toMap(Supplier supplier, SyncExportContext context) {
    return {
      'id': supplier.id,
      'name': supplier.name,
      'phone': supplier.phone,
      'email': supplier.email,
      'address': supplier.address,
      'creditBalance': supplier.creditBalance,
      'gstNumber': supplier.gstNumber,
      'isActive': supplier.isActive,
      'createdAt': supplier.createdAt.toIso8601String(),
      'updatedAt': supplier.updatedAt.toIso8601String(),
      'syncId': supplier.syncId,
      'deletedAt': supplier.deletedAt?.toIso8601String(),
    };
  }

  @override
  SuppliersCompanion toCompanion(
    Map<String, dynamic> json,
    SyncImportContext context,
  ) {
    return SuppliersCompanion(
      id: Value(json['id']),

      name: Value(json['name'] ?? ''),

      phone: Value(json['phone'] ?? ''),

      email: Value(json['email']),

      address: Value(json['address']),

      creditBalance: Value((json['creditBalance'] as num?)?.toDouble() ?? 0),

      gstNumber: Value(json['gstNumber']),

      isActive: Value(json['isActive'] ?? true),

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
