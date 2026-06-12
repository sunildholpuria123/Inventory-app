import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart';
import '../models/purchase_item.dart';
import '../provider/purchase_provider.dart';

class PurchaseProductDropdown extends ConsumerWidget {
  const PurchaseProductDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return products.when(
      data: (items) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'Add Product'),

          items: items.map((product) {
            return DropdownMenuItem(value: product, child: Text(product.name));
          }).toList(),

          onChanged: (value) {
            if (value == null) return;

            final current = ref.read(purchaseItemsProvider);

            ref.read(purchaseItemsProvider.notifier).state = [
              ...current,
              PurchaseItem(product: value, qty: 1, price: value.purchasePrice),
            ];
          },
        );
      },

      loading: () => const CircularProgressIndicator(),

      error: (e, _) => Text(e.toString()),
    );
  }
}
