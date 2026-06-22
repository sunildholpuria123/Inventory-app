import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_forecast_provider.dart';

class PurchaseForecastCard extends ConsumerWidget {
  const PurchaseForecastCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(purchaseForecastProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: forecast.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Data');
            }

            final last = items.last;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase Forecast',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                Text('Next Month'),

                Text(
                  '₹${last.amount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text('Error'),
        ),
      ),
    );
  }
}
