import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../products/provider/product_provider.dart';
import '../model/invoice_item.dart';
import '../provider/sales_provider.dart';

class ProductDropdown
    extends ConsumerWidget {
  const ProductDropdown({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final products =
    ref.watch(productsProvider);

    return products.when(
      data: (items) {
        return DropdownButtonFormField(
          decoration:
          const InputDecoration(
            labelText:
            'Add Product',
          ),

          items: items.map((product) {
            return DropdownMenuItem(
              value: product,

              child: Text(
                product.name,
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value == null) return;

            final current = ref.read(
              invoiceItemsProvider,
            );

            ref
                .read(
              invoiceItemsProvider
                  .notifier,
            )
                .state = [
              ...current,
              InvoiceItem(
                product: value,
                qty: 1,
                price:
                value.sellingPrice,
              ),
            ];
          },
        );
      },

      loading: () =>
      const CircularProgressIndicator(),

      error: (e, _) =>
          Text(e.toString()),
    );
  }
}