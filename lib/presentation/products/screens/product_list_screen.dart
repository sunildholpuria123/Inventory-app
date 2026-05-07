import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_provider.dart';
import '../widgets/add_product_dialog.dart';
import '../widgets/product_table.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Products',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                      const AddProductDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search Product',
                prefixIcon:
                const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: products.when(
                  data: (items) {
                    final search = ref.watch(
                      productSearchProvider,
                    );

                    final filtered =
                    items.where((product) {
                      return product.name
                          .toLowerCase()
                          .contains(
                        search.toLowerCase(),
                      );
                    }).toList();

                    return ProductTable(
                      products: filtered,
                    );
                  },
                loading: () => const Center(
                  child:
                  CircularProgressIndicator(),
                ),
                error: (e, _) => Center(
                  child: Text(e.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}