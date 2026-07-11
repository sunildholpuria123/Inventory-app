import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/supplier_recommendation_model.dart';
import 'purchase_forecast_provider.dart';

final supplierRecommendationProvider =
    FutureProvider<List<SupplierRecommendationModel>>((ref) {
      return ref
          .watch(analyticsRepositoryProvider)
          .getSupplierRecommendations();
    });
