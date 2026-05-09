import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_provider.dart';
import 'edit_product_dialog.dart';

class ProductTable extends ConsumerWidget {
  final List<Product> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                ),

                child: DataTable(
                  dataRowMinHeight: 60,
                  dataRowMaxHeight: 60,
                  headingRowHeight: 60,
                  columnSpacing: 30,
                  horizontalMargin: 20,

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
                          Text(
                            product.id.toString(),
                          ),
                        ),

                        DataCell(
                          Text(product.name),
                        ),

                        DataCell(
                          Text(
                            product.stockQty
                                .toString(),

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
                            mainAxisSize:
                            MainAxisSize.min,

                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,

                                    builder: (_) =>
                                        EditProductDialog(
                                          product:
                                          product,
                                        ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),

                              IconButton(
                                onPressed: () async {
                                  final repo =
                                  ref.read(
                                    productRepositoryProvider,
                                  );

                                  await repo
                                      .deleteProduct(
                                    product.id,
                                  );
                                },

                                icon: const Icon(
                                  Icons.delete,
                                  color:
                                  Colors.red,
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
            ),
          );
        },
      ),
    );
  }
}
