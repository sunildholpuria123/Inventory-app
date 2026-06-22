import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_price_provider.dart';

class ProductPriceHistoryScreen extends ConsumerWidget {
  final Product product;

  const ProductPriceHistoryScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(productPriceHistoryProvider(product.id));

    return Scaffold(
      appBar: AppBar(title: Text('${product.name} Price History')),

      body: history.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Price History'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: items.length,

            itemBuilder: (context, index) {
              final item = items[index];

              return Card(
                child: ListTile(
                  title: Text(
                    '₹${item.oldPurchasePrice.toStringAsFixed(2)}'
                    ' → '
                    '₹${item.newPurchasePrice.toStringAsFixed(2)}',
                  ),

                  subtitle: Text(
                    '${item.inflationPercentage.toStringAsFixed(2)}%',
                  ),

                  trailing: Text(item.changedAt.toString().split(' ').first),
                ),
              );
            },
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
