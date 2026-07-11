import 'package:drift/drift.dart';
import 'package:inventory_desktop/sync/context/sync_export_context.dart';
import 'package:inventory_desktop/sync/context/sync_import_context.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class CategorySyncMapper
    implements BaseSyncMapper<Category, CategoriesCompanion> {
  const CategorySyncMapper();

  @override
  CategoriesCompanion toCompanion(
    Map<String, dynamic> json,
    SyncImportContext context,
  ) {
    return CategoriesCompanion(
      id: Value(json['id']),
      name: Value(json['name'] ?? ''),
      pricingType: Value(json['pricingType'] ?? ''),
      unit: Value(json['unit'] ?? ''),
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

  @override
  Map<String, dynamic> toMap(Category category, SyncExportContext context) {
    // TODO: implement toMap
    return {
      'id': category.id,
      'name': category.name,
      'pricingType': category.pricingType,
      'unit': category.unit,
      'isActive': category.isActive,
      'createdAt': category.createdAt.toIso8601String(),
      'updatedAt': category.updatedAt.toIso8601String(),
      'syncId': category.syncId,
      'deletedAt': category.deletedAt?.toIso8601String(),
    };
  }
}
