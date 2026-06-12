import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart' show topProductsProvider;

class TopProductsWidget extends ConsumerWidget {
  const TopProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(topProductsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Top Selling Products',

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            products.when(
              data: (items) {
                return ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: items.length,

                  itemBuilder: (context, index) {
                    final product = items[index];

                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),

                      title: Text(product.productName),

                      subtitle: Text('Qty Sold: ${product.totalQty}'),

                      trailing: Text('₹${product.revenue.toStringAsFixed(0)}'),
                    );
                  },
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
