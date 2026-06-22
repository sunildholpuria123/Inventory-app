import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/seasonal_forecast_provider.dart';

class SeasonalForecastCard
    extends ConsumerWidget {
  const SeasonalForecastCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final forecast =
    ref.watch(
      seasonalForecastProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child:
        forecast.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text(
                'No Forecast Data',
              );
            }

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'Seasonal Forecast',
                  style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                ...items.map(
                      (e) => Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                          Text(
                            'Month ${e.month}',
                          ),
                        ),
                        Text(
                          '₹${e.forecastAmount.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          loading:
              () =>
          const Center(
            child:
            CircularProgressIndicator(),
          ),
          error:
              (e, _) =>
              Text(
                e.toString(),
              ),
        ),
      ),
    );
  }
}