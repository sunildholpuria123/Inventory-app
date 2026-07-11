import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/purchase_budget_model.dart';
import 'purchase_forecast_provider.dart';

final purchaseBudgetProvider = FutureProvider<PurchaseBudgetModel>((ref) {
  return ref.watch(analyticsRepositoryProvider).getPurchaseBudget();
});
