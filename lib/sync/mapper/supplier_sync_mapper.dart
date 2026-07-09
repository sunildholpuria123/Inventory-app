import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class SupplierSyncMapper
    implements BaseSyncMapper<Supplier, SuppliersCompanion> {
  @override
  Map<String, dynamic> toMap(Supplier supplier) {
    return {
      'syncId': supplier.syncId,
      'name': supplier.name,
      'phone': supplier.phone,
      'email': supplier.email,
      'address': supplier.address,
      'gstNumber': supplier.gstNumber,
      'creditBalance': supplier.creditBalance,
      'isActive': supplier.isActive,
      'createdAt': supplier.createdAt.toIso8601String(),
      'updatedAt': supplier.updatedAt.toIso8601String(),
      'deletedAt': supplier.deletedAt?.toIso8601String(),
    };
  }

  @override
  SuppliersCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return SuppliersCompanion(
      syncId: Value(json['syncId']),
      name: Value(json['name']),
      phone: Value(json['phone']),
      email: Value(json['email']),
      address: Value(json['address']),
      gstNumber: Value(json['gstNumber']),
      creditBalance: Value(
        (json['creditBalance'] as num).toDouble(),
      ),
      isActive: Value(json['isActive'] as bool),
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