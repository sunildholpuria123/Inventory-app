import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/low_stock_provider.dart';

class LowStockWidget
    extends ConsumerWidget {
  const LowStockWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final lowStock =
    ref.watch(
      lowStockProductsProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            const Text(
              'Low Stock Products',

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            lowStock.when(
              data: (products) {
                if (products
                    .isEmpty) {
                  return const Text(
                    'No Low Stock Products',
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount:
                  products.length,

                  itemBuilder: (
                      context,
                      index,
                      ) {
                    final product =
                    products[
                    index];

                    return ListTile(
                      leading:
                      const Icon(
                        Icons.warning,
                        color:
                        Colors.red,
                      ),

                      title: Text(
                        product.name,
                      ),

                      trailing: Text(
                        'Qty: ${product.stockQty}',

                        style:
                        const TextStyle(
                          color:
                          Colors.red,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },

              loading: () =>
              const CircularProgressIndicator(),

              error: (e, _) =>
                  Text(
                    e.toString(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}