import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import 'base_sync_mapper.dart';

class BusinessSettingsSyncMapper
    implements BaseSyncMapper<BusinessSetting, BusinessSettingsCompanion> {
  const BusinessSettingsSyncMapper();

  @override
  Map<String, dynamic> toMap(
    BusinessSetting setting,
    SyncExportContext context,
  ) {
    return {
      'id': setting.id,
      'companyName': setting.companyName,
      'ownerName': setting.ownerName,
      'phone': setting.phone,
      'email': setting.email,
      'address': setting.address,
      'gstNo': setting.gstNo,
      'logoPath': setting.logoPath,
      'bankName': setting.bankName,
      'accountNumber': setting.accountNumber,
      'ifscCode': setting.ifscCode,
      'upiId': setting.upiId,
      'footerMessage': setting.footerMessage,

      // Include these only if you've added them to the table
      'createdAt': setting.createdAt.toIso8601String(),
      'updatedAt': setting.updatedAt.toIso8601String(),
      'syncId': setting.syncId,
      'deletedAt': setting.deletedAt?.toIso8601String(),
    };
  }

  @override
  BusinessSettingsCompanion toCompanion(
    Map<String, dynamic> json,
    SyncImportContext context,
  ) {
    return BusinessSettingsCompanion(
      id: Value(json['id']),

      companyName: Value(json['companyName'] ?? ''),

      ownerName: Value(json['ownerName']),

      phone: Value(json['phone']),

      email: Value(json['email']),

      address: Value(json['address']),

      gstNo: Value(json['gstNo']),

      logoPath: Value(json['logoPath']),

      bankName: Value(json['bankName']),

      accountNumber: Value(json['accountNumber']),

      ifscCode: Value(json['ifscCode']),

      upiId: Value(json['upiId']),

      footerMessage: Value(json['footerMessage']),

      // Include these only if you've added them
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
