import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/purchases/widgets/purchase_variant_selection_dialog.dart';

import '../../../data/database/app_database.dart';
import '../../products/provider/product_provider.dart';
import '../../products/provider/product_variant_provider.dart';
import '../models/purchase_item.dart';
import '../provider/purchase_provider.dart';

class PurchaseProductDropdown extends ConsumerWidget {
  const PurchaseProductDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return products.when(
      data: (items) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'Add Product'),

          items: items.map((product) {
            return DropdownMenuItem(value: product, child: Text(product.name));
          }).toList(),

          onChanged: (value) async {
            if (value == null) {
              return;
            }

            final current = ref.read(purchaseItemsProvider);

            ProductVariant? selectedVariant;

            final variants = await ref
                .read(productVariantRepositoryProvider)
                .watchVariants(value.id)
                .first;

            if (variants.isNotEmpty) {
              selectedVariant = await showDialog<ProductVariant>(
                context: context,

                builder: (_) =>
                    PurchaseVariantSelectionDialog(productId: value.id),
              );

              if (selectedVariant == null) {
                return;
              }
            }

            ref.read(purchaseItemsProvider.notifier).state = [
              ...current,

              PurchaseCartItem(
                product: value,

                variant: selectedVariant,

                qty: 1,

                price: selectedVariant?.purchasePrice ?? value.purchasePrice,
              ),
            ];
          },
        );
      },

      loading: () => const CircularProgressIndicator(),

      error: (e, _) => Text(e.toString()),
    );
  }
}
