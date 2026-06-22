import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/supplier_risk_model.dart';
import 'purchase_forecast_provider.dart';

final supplierRiskProvider = FutureProvider<List<SupplierRiskModel>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getSupplierRiskAnalysis();
});
