import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/inventory_optimization_model.dart';
import 'purchase_forecast_provider.dart';

final inventoryOptimizationProvider =
    FutureProvider<List<InventoryOptimizationModel>>((ref) {
      return ref.watch(analyticsRepositoryProvider).getInventoryOptimization();
    });
