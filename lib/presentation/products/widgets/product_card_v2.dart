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

    final isLowStock = product.stockQty <= product.minStock;

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.imagePath == null
                    ? CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: const Icon(Icons.inventory_2),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(product.imagePath!),
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 26,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category?.name ?? 'No Category',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'history':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductPriceHistoryScreen(product: product),
                          ),
                        );
                        break;

                      case 'edit':
                        showDialog(
                          context: context,
                          builder: (_) =>
                              EditProductDialog(product: product),
                        );
                        break;

                      case 'detail':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                        break;

                      case 'delete':
                        ref
                            .read(productRepositoryProvider)
                            .deleteProduct(product);
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

              ],
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(category?.unit ?? '-'),
                ),
                Chip(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: isLowStock
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                  label: Text(
                    isLowStock
                        ? 'Low Stock'
                        : 'In Stock',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      title: 'Stock',
                      value: product.stockQty.toString(),
                    ),
                  ),
                  Expanded(
                    child: _InfoTile(
                      title: 'Buy',
                      value:
                      '₹${product.purchasePrice.toStringAsFixed(0)}',
                    ),
                  ),
                  Expanded(
                    child: _InfoTile(
                      title: 'Sell',
                      value:
                      '₹${product.sellingPrice.toStringAsFixed(0)}',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        ),
      ],
    );
  }
}