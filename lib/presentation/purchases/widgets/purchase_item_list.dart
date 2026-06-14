import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_provider.dart';

class PurchaseItemList extends ConsumerWidget {
  const PurchaseItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(purchaseItemsProvider);

    return Card(
      child: ListView.builder(
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item.displayName),

            subtitle: Text(
              'Qty: ${item.qty}'
              '\nRs.${item.price.toStringAsFixed(2)}',
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text('Rs.${item.total.toStringAsFixed(2)}'),

                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),

                  onPressed: () {
                    final updated = [...items];

                    updated.removeAt(index);

                    ref.read(purchaseItemsProvider.notifier).state = updated;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
