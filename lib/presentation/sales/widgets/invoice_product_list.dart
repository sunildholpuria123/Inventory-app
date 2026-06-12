import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item.dart' show CartItem;
import '../provider/sales_provider.dart';

class InvoiceProductList extends ConsumerWidget {
  const InvoiceProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(invoiceItemsProvider);

    if (items.isEmpty) {
      return const Center(child: Text('No Products Added'));
    }

    return ListView.builder(
      shrinkWrap: true,

      itemCount: items.length,

      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text('₹${item.price}'),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    if (item.qty <= 1) {
                      return;
                    }

                    final updated = [...items];

                    updated[index] = CartItem(
                      product: item.product,
                      qty: item.qty - 1,
                      price: item.price,
                    );

                    ref.read(invoiceItemsProvider.notifier).state = updated;
                  },
                  icon: const Icon(Icons.remove_circle),
                ),

                Text(
                  item.qty.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    final updated = [...items];

                    updated[index] = CartItem(
                      product: item.product,
                      qty: item.qty + 1,
                      price: item.price,
                    );

                    ref.read(invoiceItemsProvider.notifier).state = updated;
                  },
                  icon: const Icon(Icons.add_circle),
                ),

                const SizedBox(width: 20),

                Text(
                  '₹${item.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                IconButton(
                  onPressed: () {
                    final updated = [...items];

                    updated.removeAt(index);

                    ref.read(invoiceItemsProvider.notifier).state = updated;
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
