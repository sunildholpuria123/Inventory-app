import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_order_provider.dart';

class PurchaseOrderCard
    extends ConsumerWidget {
  const PurchaseOrderCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final orders =
    ref.watch(
      purchaseOrderProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: orders.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text(
                'No Purchase Orders Required',
              );
            }

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'Automatic Purchase Orders',
                  style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                ...items.take(5).map(
                      (e) => ListTile(
                    dense: true,
                    title: Text(
                      e.productName,
                    ),
                    subtitle: Text(
                      e.supplierName,
                    ),
                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Text(
                          'Qty ${e.quantity}',
                        ),
                        Text(
                          '₹${e.estimatedCost.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
              Text(
                e.toString(),
              ),
        ),
      ),
    );
  }
}