import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_variant_provider.dart';

class PurchaseVariantSelectionDialog extends ConsumerWidget {
  final int productId;

  const PurchaseVariantSelectionDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variants = ref.watch(variantsProvider(productId));

    return AlertDialog(
      title: const Text('Select Variant'),

      content: SizedBox(
        width: 400,

        child: variants.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Variants Available');
            }

            return ListView.builder(
              shrinkWrap: true,

              itemCount: items.length,

              itemBuilder: (context, index) {
                final variant = items[index];

                return ListTile(
                  title: Text(variant.variantName),

                  subtitle: Text(
                    'Stock: '
                    '${variant.stockQty}',
                  ),

                  trailing: Text('₹${variant.purchasePrice}'),

                  onTap: () {
                    Navigator.pop(context, variant);
                  },
                );
              },
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Text(e.toString()),
        ),
      ),
    );
  }
}
