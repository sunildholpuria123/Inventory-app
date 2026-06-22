import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_forecast_provider.dart';

class ForecastChartWidget
    extends ConsumerWidget {
  const ForecastChartWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final forecast = ref.watch(
      purchaseForecastProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: forecast.when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(
                child:
                Text('No Forecast Data'),
              );
            }

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase Forecast',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 20),

                ...items.map(
                      (e) => Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                          Text(e.month),
                        ),
                        Text(
                          '₹${e.amount.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child:
            CircularProgressIndicator(),
          ),
          error: (e, _) =>
              Text(e.toString()),
        ),
      ),
    );
  }
}