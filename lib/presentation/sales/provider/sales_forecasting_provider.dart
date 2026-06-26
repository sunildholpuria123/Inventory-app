import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sales/provider/sales_analytics_provider.dart';


class SalesForecast {
  final double nextMonthPrediction;

  const SalesForecast({
    required this.nextMonthPrediction,
  });
}

final salesForecastProvider =
FutureProvider<SalesForecast>(
      (ref) async {
    final sales =
    await ref.watch(
      monthlySalesProvider.future,
    );

    if (sales.isEmpty) {
      return const SalesForecast(
        nextMonthPrediction:
        0,
      );
    }

    final total =
    sales.fold<double>(
      0,
          (sum, e) =>
      sum + e.amount,
    );

    return SalesForecast(
      nextMonthPrediction:
      total /
          sales.length,
    );
  },
);