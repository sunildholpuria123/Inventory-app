import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/inventory_optimization_provider.dart';

class InventoryOptimizationCard extends ConsumerWidget {
  const InventoryOptimizationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optimization = ref.watch(inventoryOptimizationProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: optimization.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Inventory Data');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Inventory Optimization',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                ...items
                    .take(5)
                    .map(
                      (e) => ListTile(
                        dense: true,
                        title: Text(e.productName),
                        subtitle: Text('Stock: ${e.currentStock}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Optimal: ${e.optimalStock}'),
                            Text('Order: ${e.reorderQty}'),
                          ],
                        ),
                      ),
                    ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text(e.toString()),
        ),
      ),
    );
  }
}
