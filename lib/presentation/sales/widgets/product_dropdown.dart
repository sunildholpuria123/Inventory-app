import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart';
import '../model/cart_item.dart';
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
  dynamic selectedProduct;

  @override
  Widget build(
      BuildContext context,
      ) {
    final products =
    ref.watch(
      productsProvider,
    );

    return products.when(
      data: (items) {
        return DropdownButtonFormField<
            dynamic>(
          value: null,

          decoration:
          const InputDecoration(
            labelText:
            'Add Product',
          ),

          items:
          items.map((product) {
            return DropdownMenuItem(
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

            final product =
            items.firstWhere(
                  (e) =>
              e.id == value,
            );

            /// OUT OF STOCK CHECK
            if (product.stockQty <= 0) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Out of stock',
                  ),
                ),
              );

              return;
            }

            final current =
            ref.read(
              invoiceItemsProvider,
            );

            /// PREVENT DUPLICATE
            final alreadyExists =
            current.any(
                  (e) =>
              e.product.id ==
                  product.id,
            );

            if (alreadyExists) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Product already added',
                  ),
                ),
              );

              return;
            }

            ref
                .read(
              invoiceItemsProvider
                  .notifier,
            )
                .state = [
              ...current,

              CartItem(
                product: product,
                qty: 1,
                price:
                product
                    .sellingPrice,
              ),
            ];

            setState(() {
              selectedProduct =
              null;
            });
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