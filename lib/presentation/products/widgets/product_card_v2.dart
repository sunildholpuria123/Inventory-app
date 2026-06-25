import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../categories/provider/category_provider.dart';
import '../provider/product_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_price_history_screen.dart';
import 'edit_product_dialog.dart';

class ProductCardV2 extends ConsumerWidget {
  final Product product;

  const ProductCardV2({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    Category? category;

    final categoryList = categories.value ?? [];

    try {
      category = categoryList.firstWhere((e) => e.id == product.categoryId);
    } catch (_) {
      category = null;
    }

    final isLowStock = product.stockQty <=
        product.minStock;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                product.imagePath == null
                    ? CircleAvatar(
                        radius: 32,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        child: const Icon(Icons.inventory_2),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(product.imagePath!),
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return CircleAvatar(
                              radius: 32,
                              child: const Icon(Icons.broken_image),
                            );
                          },
                        ),
                      ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        category?.name ?? 'No Category',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text(category?.unit ?? '-')),
                          Chip(
                            label: Text(isLowStock ? 'Low Stock' : 'In Stock'),
                            backgroundColor: isLowStock
                                ? Colors.red.shade100
                                : Colors.green.shade100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    title: 'Stock',
                    value: product.stockQty.toString(),
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    title: 'Purchase',
                    value: '₹${product.purchasePrice.toStringAsFixed(2)}',
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    title: 'Selling',
                    value: '₹${product.sellingPrice.toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            Align(
              alignment:
              Alignment.centerRight,
              child:
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'history':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductPriceHistoryScreen(
                                product: product,
                              ),
                        ),
                      );
                      break;

                    case 'edit':
                      showDialog(
                        context: context,
                        builder: (_) =>
                            EditProductDialog(
                              product: product,
                            ),
                      );
                      break;

                    case 'detail':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailScreen(
                                product: product,
                              ),
                        ),
                      );
                      break;

                    case 'delete':
                      ref
                          .read(
                        productRepositoryProvider,
                      )
                          .deleteProduct(
                        product,
                      );
                      break;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'detail',
                    child: Text('Details'),
                  ),
                  PopupMenuItem(
                    value: 'history',
                    child: Text('Price History'),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            )          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
