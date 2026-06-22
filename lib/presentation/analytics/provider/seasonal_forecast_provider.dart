import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/seasonal_forecast_model.dart';
import 'purchase_forecast_provider.dart';

final seasonalForecastProvider =
FutureProvider<
    List<SeasonalForecastModel>>(
      (ref) {
    return ref
        .watch(
      analyticsRepositoryProvider,
    )
        .getSeasonalForecast();
  },
);