import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class LowStockWidget extends ConsumerWidget {
  const LowStockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(lowStockProvider);

    return Card(
      child: SizedBox(
        height: 250, // Fixed height

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Low Stock Alerts',

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: products.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('No Low Stock Products'));
                    }

                    return ListView.builder(
                      itemCount: items.length,

                      itemBuilder: (context, index) {
                        final product = items[index];

                        return ListTile(
                          dense: true,

                          contentPadding: EdgeInsets.zero,

                          leading: const Icon(Icons.warning, color: Colors.red),

                          title: Text(
                            product.name,

                            overflow: TextOverflow.ellipsis,
                          ),

                          trailing: Text(
                            'Qty: ${product.stockQty}',

                            style: const TextStyle(
                              color: Colors.red,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },

                  loading: () =>
                      const Center(child: CircularProgressIndicator()),

                  error: (e, _) => Center(child: Text(e.toString())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
