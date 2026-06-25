import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../categories/provider/category_provider.dart';
import '../provider/product_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_price_history_screen.dart';
import 'edit_product_dialog.dart';

class ProductTable extends ConsumerWidget {
  final List<Product> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    final categoryMap = {
      for (final category in categories.value ?? []) category.id: category,
    };
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            dataRowMinHeight: 70,
            dataRowMaxHeight: 70,

            headingRowHeight: 60,

            columnSpacing: 25,

            horizontalMargin: 20,

            columns: const [
              DataColumn(label: Text('Image')),

              DataColumn(label: Text('ID')),

              DataColumn(label: Text('Name')),

              DataColumn(label: Text('Category')),

              DataColumn(label: Text('Unit')),

              DataColumn(label: Text('Pricing')),

              DataColumn(label: Text('Stock')),

              DataColumn(label: Text('Purchase')),

              DataColumn(label: Text('Selling')),

              DataColumn(label: Text('Actions')),
            ],
            rows: products.map((product) {
              return DataRow(
                cells: [
                  /// IMAGE
                  DataCell(
                    product.imagePath == null
                        ? const CircleAvatar(child: Icon(Icons.image))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),

                            child: Image.file(
                              File(product.imagePath!),

                              width: 50,
                              height: 50,

                              fit: BoxFit.cover,

                              errorBuilder: (_, __, ___) {
                                return const CircleAvatar(
                                  child: Icon(Icons.broken_image),
                                );
                              },
                            ),
                          ),
                  ),

                  /// ID
                  DataCell(Text(product.id.toString())),

                  /// NAME
                  DataCell(Text(product.name)),

                  DataCell(Text(categoryMap[product.categoryId]?.name ?? '-')),

                  DataCell(Text(categoryMap[product.categoryId]?.unit ?? '-')),

                  DataCell(
                    Text(categoryMap[product.categoryId]?.pricingType ?? '-'),
                  ),

                  /// STOCK
                  DataCell(
                    Text(
                      product.stockQty.toString(),

                      style: TextStyle(
                        color:product.stockQty <=
                            product.minStock
                            ? Colors.red
                            : Colors.green,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// PURCHASE PRICE
                  DataCell(Text('Rs.${product.purchasePrice}')),

                  /// SELLING PRICE
                  DataCell(Text('Rs.${product.sellingPrice}')),

                  /// ACTIONS
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        //History
                        IconButton(
                          icon: const Icon(Icons.history),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductPriceHistoryScreen(product: product),
                              ),
                            );
                          },
                        ),

                        /// EDIT
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,

                              builder: (_) =>
                                  EditProductDialog(product: product),
                            );
                          },

                          icon: const Icon(Icons.edit),
                        ),

                        /// DELETE
                        IconButton(
                          onPressed: () async {
                            final repo = ref.read(productRepositoryProvider);

                            await repo.deleteProduct(product);
                          },

                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),

                          onPressed: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
