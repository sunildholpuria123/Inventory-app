import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_variant_provider.dart';
import 'add_edit_variant_dialog.dart';

class VariantListWidget extends ConsumerWidget {
  final int productId;

  const VariantListWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variants = ref.watch(variantsProvider(productId));

    return variants.when(
      data: (items) {
        if (items.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),

              child: Center(child: Text('No Variants')),
            ),
          );
        }

        return Column(
          children: items.map((variant) {
            return Card(
              child: ListTile(
                title: Text(variant.variantName),

                subtitle: Text(
                  [
                    variant.thickness,
                    variant.color,
                    variant.size,
                  ].where((e) => e != null).join(' • '),
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('₹${variant.sellingPrice}'),

                    Text('Stock: ${variant.stockQty}'),
                  ],
                ),

                onTap: () {
                  showDialog(
                    context: context,

                    builder: (_) => AddEditVariantDialog(
                      productId: productId,

                      variant: variant,
                    ),
                  );
                },

                onLongPress: () async {
                  final confirm = await showDialog<bool>(
                    context: context,

                    builder: (_) => AlertDialog(
                      title: const Text('Delete Variant'),

                      content: const Text('Delete this variant?'),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },

                          child: const Text('Cancel'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },

                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await ref
                        .read(productVariantRepositoryProvider)
                        .deleteVariant(variant.id);
                  }
                },
              ),
            );
          }).toList(),
        );
      },

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Text(e.toString()),
    );
  }
}
