import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_forecasting_provider.dart';

class SalesForecastWidget
    extends ConsumerWidget {
  const SalesForecastWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final forecast =
    ref.watch(
      salesForecastProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: forecast.when(
          data: (data) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Sales Forecast',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 20),

                ListTile(
                  title: const Text(
                    'Predicted Revenue',
                  ),
                  trailing: Text(
                    '₹${data.nextMonthPrediction.toStringAsFixed(0)}',
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
              Text(e.toString()),
        ),
      ),
    );
  }
}