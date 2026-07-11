import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_price_provider.dart';

class InflationDashboardCard extends ConsumerWidget {
  const InflationDashboardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(inflationHistoryProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: history.when(
          data: (items) {
            final increased = items
                .where((e) => e.inflationPercentage > 0)
                .length;

            return Column(
              children: [
                Text(
                  'Price Increased Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 16),

                Text(
                  increased.toString(),

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
