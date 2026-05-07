import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_provider.dart';

class ProductTable extends ConsumerWidget {
  final List<Product> products;

  const ProductTable({
    super.key,
    required this.products,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Stock'),
            ),
            DataColumn(
              label: Text('Purchase'),
            ),
            DataColumn(
              label: Text('Selling'),
            ),
            DataColumn(
              label: Text('Actions'),
            ),
          ],
          rows: products.map((product) {
            return DataRow(
              cells: [
                DataCell(
                  Text(product.id.toString()),
                ),

                DataCell(
                  Text(product.name),
                ),

                DataCell(
                  Text(
                    product.stockQty.toString(),
                    style: TextStyle(
                      color:
                      product.stockQty <= 5
                          ? Colors.red
                          : Colors.green,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                DataCell(
                  Text(
                    '₹${product.purchasePrice}',
                  ),
                ),

                DataCell(
                  Text(
                    '₹${product.sellingPrice}',
                  ),
                ),

                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),

                      IconButton(
                        onPressed: () async {
                          final repo = ref.read(
                            productRepositoryProvider,
                          );

                          await repo.deleteProduct(
                            product.id,
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}