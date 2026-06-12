import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/pagination_provider.dart';
import '../../categories/provider/category_provider.dart';
import '../provider/product_provider.dart';
import '../widgets/add_product_dialog.dart';
import '../widgets/grouped_product_table.dart';
import '../widgets/product_table.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    final categories = ref.watch(categoriesProvider);

    final currentPage = ref.watch(currentPageProvider);

    final pageSize = ref.watch(pageSizeProvider);

    final selectedCategory = ref.watch(productCategoryFilterProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Products',

                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,

                      builder: (_) => const AddProductDialog(),
                    );
                  },

                  icon: const Icon(Icons.add),

                  label: const Text('Add Product'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Product',

                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              onChanged: (value) {
                ref.read(productSearchProvider.notifier).state = value;

                ref.read(currentPageProvider.notifier).state = 1;
              },
            ),

            const SizedBox(height: 15),

            /// CATEGORY FILTER
            categories.when(
              data: (items) {
                return DropdownButtonFormField<int?>(
                  value: selectedCategory,

                  decoration: InputDecoration(
                    labelText: 'Category',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,

                      child: Text('All Categories'),
                    ),

                    ...items.map((category) {
                      return DropdownMenuItem<int?>(
                        value: category.id,

                        child: Text(category.name),
                      );
                    }),
                  ],

                  onChanged: (value) {
                    ref.read(productCategoryFilterProvider.notifier).state =
                        value;

                    ref.read(currentPageProvider.notifier).state = 1;
                  },
                );
              },

              loading: () => const LinearProgressIndicator(),

              error: (e, _) => Text(e.toString()),
            ),

            const SizedBox(height: 20),

            /// PRODUCTS
            Expanded(
              child: Builder(
                builder: (_) {
                  final groupedProducts = ref.watch(groupedProductsProvider);

                  return groupedProducts.when(
                    data: (groups) {
                      if (groups.isEmpty) {
                        return const Center(child: Text('No Products Found'));
                      }

                      return GroupedProductTable(groups: groups);
                    },

                    loading: () =>
                        const Center(child: CircularProgressIndicator()),

                    error: (e, _) => Center(child: Text(e.toString())),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
