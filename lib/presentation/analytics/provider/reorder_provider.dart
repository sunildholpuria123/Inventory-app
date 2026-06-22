import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/analytics/provider/purchase_forecast_provider.dart';

final reorderSuggestionProvider = FutureProvider((ref) {
  return ref.watch(analyticsRepositoryProvider).getReorderSuggestions();
});
