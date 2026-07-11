import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/analytics/provider/purchase_forecast_provider.dart';

import '../model/supplier_score_model.dart';

final supplierPerformanceProvider =
FutureProvider<List<SupplierScoreModel>>(
      (ref) {
    return ref
        .watch(
      analyticsRepositoryProvider,
    )
        .getSupplierScores();
  },
);