import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_settings.dart';


final settingsProvider =
StateProvider<AppSettings>(
      (ref) {
    return const AppSettings(
      darkMode: false,
      currency: '₹',
      taxPercent: 18,
      companyName:
      'Inventory ERP',
      companyAddress:
      'Kota Rajasthan',
      invoicePrefix: 'INV',
    );
  },
);