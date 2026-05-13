import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart';

import '../model/invoice_item.dart';

import '../provider/sales_provider.dart';

class ProductDropdown
    extends ConsumerStatefulWidget {
  const ProductDropdown({
    super.key,
  });

  @override
  ConsumerState<ProductDropdown>
  createState() =>
      _ProductDropdownState();
}

class _ProductDropdownState
    extends ConsumerState<
        ProductDropdown> {
  int? selectedProductId;

  @override
  Widget build(
      BuildContext context,
      ) {
    final products = ref.watch(
      productsProvider,
    );

    return products.when(
      data: (items) {
        return DropdownButtonFormField<
            int>(
          value: selectedProductId,

          decoration:
          const InputDecoration(
            labelText:
            'Add Product',
          ),

          items: items.map((product) {
            return DropdownMenuItem<
                int>(
              value: product.id,

              child: Text(
                product.name,
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value == null) {
              return;
            }

            setState(() {
              selectedProductId =
                  value;
            });

            final selectedProduct =
            items.firstWhere(
                  (e) => e.id == value,
            );

            final current =
            ref.read(
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
                product:
                selectedProduct,

                qty: 1,

                price:
                selectedProduct
                    .sellingPrice,
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