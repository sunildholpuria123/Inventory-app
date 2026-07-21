import '../../../data/database/app_database.dart';
import 'package:drift/drift.dart';

class BusinessSettingsRepository {
  final AppDatabase db;

  BusinessSettingsRepository(this.db);

  Future<BusinessSetting?> getSettings() async {
    return db.select(db.businessSettings).getSingleOrNull();
  }

  Future<void> saveSettings(BusinessSettingsCompanion data) async {
    final existing = await getSettings();

    if (existing == null) {
      await db.into(db.businessSettings).insert(data);
    } else {
      await db
          .update(db.businessSettings)
          .replace(
            BusinessSetting(
              id: existing.id,

              companyName: data.companyName.value,

              ownerName: data.ownerName.value,

              phone: data.phone.value,

              email: data.email.value,

              address: data.address.value,

              gstNo: data.gstNo.value,

              logoPath: data.logoPath.value,

              bankName: data.bankName.value,

              accountNumber: data.accountNumber.value,

              ifscCode: data.ifscCode.value,

              upiId: data.upiId.value,

              footerMessage: data.footerMessage.value,
              createdAt: existing.createdAt,
              updatedAt: DateTime.now(),
              syncId: existing.syncId,
              deletedAt: existing.deletedAt,
              upiMerchantName: data.upiMerchantName.present
                  ? data.upiMerchantName.value
                  : existing.upiMerchantName,

              upiQrImagePath: data.upiQrImagePath.present
                  ? data.upiQrImagePath.value
                  : existing.upiQrImagePath,

              enableUpiPayment: data.enableUpiPayment.present
                  ? data.enableUpiPayment.value
                  : existing.enableUpiPayment,
            ),
          );
    }
  }
}
