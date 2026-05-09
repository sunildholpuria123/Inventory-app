import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_provider.dart';

class PurchaseItemList
    extends ConsumerWidget {
  const PurchaseItemList({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final items = ref.watch(
      purchaseItemsProvider,
    );

    return Card(
      child: ListView.builder(
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title:
            Text(item.product.name),

            subtitle: Text(
              'Qty: ${item.qty}',
            ),

            trailing: Text(
              '₹${item.subtotal}',
            ),
          );
        },
      ),
    );
  }
}