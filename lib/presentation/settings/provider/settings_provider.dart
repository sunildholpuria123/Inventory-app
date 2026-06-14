import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/business_settings_repository.dart';
import '../model/app_settings.dart';

final settingsProvider = StateProvider<AppSettings>((ref) {
  return const AppSettings(
    darkMode: false,
    currency: '₹',
    taxPercent: 18,
    companyName: 'Inventory ERP',
    companyAddress: 'Kota Rajasthan',
    invoicePrefix: 'INV',
  );
});

final businessSettingsRepositoryProvider = Provider((ref) {
  return BusinessSettingsRepository(ref.watch(databaseProvider));
});

final businessSettingsProvider = FutureProvider((ref) {
  return ref.watch(businessSettingsRepositoryProvider).getSettings();
});
