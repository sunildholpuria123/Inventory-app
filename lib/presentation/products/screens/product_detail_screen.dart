import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_variant_provider.dart';
import '../widgets/add_edit_variant_dialog.dart';
import '../widgets/variant_list_widget.dart';
import '../widgets/variant_summary_card.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variants = ref.watch(variantsProvider(product.id));

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,

            builder: (_) => AddEditVariantDialog(productId: product.id),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: product.imagePath == null
                  ? const CircleAvatar(
                      radius: 50,

                      child: Icon(Icons.inventory, size: 40),
                    )
                  : CircleAvatar(
                      radius: 50,

                      backgroundImage: FileImage(File(product.imagePath!)),
                    ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.name,

                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text('Stock: ${product.stockQty}'),

                    Text('Purchase: Rs.${product.purchasePrice}'),

                    Text('Selling: Rs.${product.sellingPrice}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            variants.when(
              data: (items) {
                return VariantSummaryCard(variants: items);
              },

              loading: () => const SizedBox(),

              error: (_, __) => const SizedBox(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Variants',

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            VariantListWidget(productId: product.id),
          ],
        ),
      ),
    );
  }
}
