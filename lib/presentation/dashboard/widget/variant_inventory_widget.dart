import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class VariantInventoryWidget extends ConsumerWidget {
  const VariantInventoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variants = ref.watch(variantInventoryProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Variant Inventory',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            variants.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Text('No Variant Data');
                }

                return Column(
                  children: items.take(10).map((item) {
                    Color color = Colors.green;

                    String status = 'Healthy';

                    if (item.lowStock) {
                      color = Colors.orange;

                      status = 'Low Stock';
                    }

                    if (item.deadStock) {
                      color = Colors.red;

                      status = 'Dead Stock';
                    }

                    if (item.fastMoving) {
                      color = Colors.blue;

                      status = 'Fast Moving';
                    }

                    return ListTile(
                      title: Text(
                        '${item.productName}'
                        ' (${item.variantName})',
                      ),

                      subtitle: Text(
                        'Stock: '
                        '${item.stock.toStringAsFixed(0)}'
                        ' | Sold: '
                        '${item.sold.toStringAsFixed(0)}',
                      ),

                      trailing: Chip(
                        label: Text(status),

                        backgroundColor: color.withOpacity(0.2),
                      ),
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
