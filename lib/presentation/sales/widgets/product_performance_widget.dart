import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_performance_provider.dart';

class ProductPerformanceWidget
    extends ConsumerWidget {
  const ProductPerformanceWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final performance =
    ref.watch(
      productPerformanceProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: performance.when(
          data: (data) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Performance',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 20),

                ListTile(
                  title: const Text(
                    'Products Sold',
                  ),
                  trailing: Text(
                    '${data.totalProductsSold}',
                  ),
                ),

                ListTile(
                  title: const Text(
                    'Revenue',
                  ),
                  trailing: Text(
                    '₹${data.totalRevenue.toStringAsFixed(0)}',
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