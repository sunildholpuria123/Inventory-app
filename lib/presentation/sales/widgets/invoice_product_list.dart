import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// PRODUCT DETAILS
                Expanded(
                  flex: 4,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item.displayName,

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 4),

                      Text('Rate: ₹${item.unitPrice.toStringAsFixed(2)}'),

                      /// AREA DETAILS
                      if (item.isAreaBased)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),

                          child: Text(
                            '${item.height} × '
                            '${item.width} × '
                            '${item.quantity} = '
                            '${(item.area * item.quantity).toStringAsFixed(2)} sqft',

                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                    ],
                  ),
                ),

                /// QUANTITY CONTROLS
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item.quantity <= 1) {
                          return;
                        }

                        final updated = [...items];

                        updated[index] = item.copyWith(
                          quantity: item.quantity - 1,
                        );

                        ref.read(invoiceItemsProvider.notifier).state = updated;
                      },

                      icon: const Icon(Icons.remove_circle),
                    ),

                    Text(
                      item.quantity.toString(),

                      style: const TextStyle(
                        fontSize: 18,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        final updated = [...items];

                        updated[index] = item.copyWith(
                          quantity: item.quantity + 1,
                        );

                        ref.read(invoiceItemsProvider.notifier).state = updated;
                      },

                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                /// TOTAL + DELETE
                Column(
                  children: [
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
              ],
            ),
          ),
        );
      },
    );
  }
}
