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
    final items = ref.watch(
      invoiceItemsProvider,
    );

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No Products Added',
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,

      itemCount: items.length,

      itemBuilder: (
          context,
          index,
          ) {
        final item =
        items[index];

        return Card(
          child: ListTile(
            title: Text(
              item.product.name,
            ),

            subtitle: Text(
              'Qty: ${item.qty} × ₹${item.price}',
            ),

            trailing: Row(
              mainAxisSize:
              MainAxisSize.min,

              children: [
                Text(
                  '₹${item.total.toStringAsFixed(2)}',
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
          ),
        );
      },
    );
  }
}