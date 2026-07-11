import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/analytics/provider/purchase_forecast_provider.dart';

import '../model/reorder_suggestion_model.dart';

final smartReorderProvider = FutureProvider<List<ReorderSuggestionModel>>((
  ref,
) {
  return ref.watch(analyticsRepositoryProvider).getReorderSuggestions();
});
