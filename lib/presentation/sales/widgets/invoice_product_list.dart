import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_provider.dart';

class InvoiceProductList
    extends ConsumerWidget {
  const InvoiceProductList({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final items =
    ref.watch(invoiceItemsProvider);

    return Card(
      child: ListView.builder(
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(
                item.qty.toString(),
              ),
            ),

            title:
            Text(item.product.name),

            subtitle: Text(
              '₹${item.price}',
            ),

            trailing: Row(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    final updated =
                    [...items];

                    updated[index] =
                        item.copyWith(
                          qty: item.qty > 1
                              ? item.qty - 1
                              : 1,
                        );

                    ref
                        .read(
                      invoiceItemsProvider
                          .notifier,
                    )
                        .state = updated;
                  },
                  icon: const Icon(
                    Icons.remove,
                  ),
                ),

                Text(
                  item.qty.toString(),
                ),

                IconButton(
                  onPressed: () {
                    final updated =
                    [...items];

                    updated[index] =
                        item.copyWith(
                          qty: item.qty + 1,
                        );

                    ref
                        .read(
                      invoiceItemsProvider
                          .notifier,
                    )
                        .state = updated;
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),

                const SizedBox(width: 20),

                Text(
                  '₹${item.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    final updated =
                    [...items];

                    updated.removeAt(
                      index,
                    );

                    ref
                        .read(
                      invoiceItemsProvider
                          .notifier,
                    )
                        .state = updated;
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}