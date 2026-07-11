import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../categories/provider/category_provider.dart';
import '../provider/product_provider.dart';
import '../provider/product_view_provider.dart';
import '../widgets/add_product_dialog.dart';
import '../widgets/grouped_product_table.dart';
import '../widgets/product_dashboard_cards.dart';
import '../widgets/product_empty_state.dart';
import '../widgets/product_grid_view.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory =
    ref.watch(productCategoryFilterProvider);

    final isMobile =
    ResponsiveHelper.isMobile(context);

    final gridView =
    ref.watch(productViewProvider);

    return Scaffold(
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) =>
            const AddProductDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Product'),
      )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const ProductDashboardCards(),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Products',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Manage inventory products',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      gridView
                          ? Icons.view_list
                          : Icons.grid_view,
                    ),
                    onPressed: () {
                      ref
                          .read(
                        productViewProvider
                            .notifier,
                      )
                          .state = !gridView;
                    },
                  ),
                  if (!isMobile)
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                          const AddProductDialog(),
                        );
                      },
                      icon:
                      const Icon(Icons.add),
                      label:
                      const Text(
                        'Add Product',
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 0,
                child: Padding(
                  padding:
                  const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration:
                        InputDecoration(
                          hintText:
                          'Search products...',
                          prefixIcon:
                          const Icon(
                            Icons.search,
                          ),
                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          ref
                              .read(
                            productSearchProvider
                                .notifier,
                          )
                              .state = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      categories.when(
                        data: (items) {
                          return SizedBox(
                            height: 45,
                            child: ListView(
                              scrollDirection:
                              Axis.horizontal,
                              children: [
                                ChoiceChip(
                                  label:
                                  const Text(
                                    'All',
                                  ),
                                  selected:
                                  selectedCategory ==
                                      null,
                                  onSelected:
                                      (_) {
                                    ref
                                        .read(
                                      productCategoryFilterProvider
                                          .notifier,
                                    )
                                        .state =
                                    null;
                                  },
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                ...items.map(
                                      (e) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(
                                        right:
                                        8,
                                      ),
                                      child:
                                      ChoiceChip(
                                        label:
                                        Text(
                                          e.name,
                                        ),
                                        selected:
                                        selectedCategory ==
                                            e.id,
                                        onSelected:
                                            (_) {
                                          ref
                                              .read(
                                            productCategoryFilterProvider
                                                .notifier,
                                          )
                                              .state =
                                              e.id;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        loading:
                            () =>
                        const LinearProgressIndicator(),
                        error:
                            (e, _) =>
                            Text(
                              e.toString(),
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Consumer(
                  builder:
                      (context, ref, _) {
                    final groups =
                    ref.watch(
                      groupedProductsProvider,
                    );

                    return groups.when(
                      data: (items) {
                        if (items.isEmpty) {
                          return const ProductEmptyState();
                        }

                        if (gridView) {
                          final products =
                          items
                              .expand(
                                (e) =>
                            e.products,
                          )
                              .toList();

                          return ProductGridView(
                            products:
                            products,
                          );
                        }

                        return GroupedProductTable(
                          groups: items,
                        );
                      },
                      loading:
                          () =>
                      const Center(
                        child:
                        CircularProgressIndicator(),
                      ),
                      error:
                          (e, _) =>
                          Center(
                            child:
                            Text(
                              e.toString(),
                            ),
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}