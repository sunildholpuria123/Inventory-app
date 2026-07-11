import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_forecasting_provider.dart';

final aiSalesRecommendationProvider = FutureProvider<List<String>>((ref) async {
  final forecast = await ref.watch(salesForecastProvider.future);

  final recommendations = <String>[];

  if (forecast.nextMonthPrediction > 100000) {
    recommendations.add('Increase inventory for next month.');
  }

  if (forecast.nextMonthPrediction < 20000) {
    recommendations.add('Run promotional offers to boost sales.');
  }

  recommendations.add('Focus on top customers and repeat purchases.');

  recommendations.add('Ensure stock availability for best-selling products.');

  return recommendations;
});
