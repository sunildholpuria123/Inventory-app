import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class VariantSalesWidget extends ConsumerWidget {
  const VariantSalesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(variantSalesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Top Variant Sales',

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            sales.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Text('No Variant Sales');
                }

                return Column(
                  children: items.take(5).map((item) {
                    return ListTile(
                      title: Text(
                        '${item.productName}'
                        ' (${item.variantName})',
                      ),

                      subtitle: Text(
                        item.areaSold > 0
                            ? 'Sold: '
                                  '${item.areaSold.toStringAsFixed(2)} sqft'
                            : 'Sold: '
                                  '${item.quantitySold.toStringAsFixed(0)}',
                      ),

                      trailing: Text('Rs.${item.revenue.toStringAsFixed(0)}'),
                    );
                  }).toList(),
                );
              },

              loading: () => const CircularProgressIndicator(),

              error: (e, _) => Text(e.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
