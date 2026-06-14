import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

class PurchaseDetailDialog extends StatelessWidget {
  final List<PurchaseItem> items;

  const PurchaseDetailDialog({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Purchase Details'),

      content: SizedBox(
        width: 500,

        child: ListView.builder(
          shrinkWrap: true,

          itemCount: items.length,

          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: Text(
                item.variantName != null
                    ? '${item.productName}'
                          ' (${item.variantName})'
                    : item.productName,
              ),

              subtitle: Text('Qty: ${item.quantity}'),

              trailing: Text('Rs.${item.total.toStringAsFixed(0)}'),
            );
          },
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text('Close'),
        ),
      ],
    );
  }
}
