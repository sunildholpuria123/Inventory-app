import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/top_selling_products_provider.dart';

class TopSellingProductsWidget
    extends ConsumerWidget {
  const TopSellingProductsWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final products =
    ref.watch(
      topSellingProductsProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          16,
        ),
        child: products.when(
          data: (items) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'Top Selling Products',
                  style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(
                  height: 16,
                ),

                ...items.map(
                      (e) => ListTile(
                    contentPadding:
                    EdgeInsets.zero,
                    leading:
                    CircleAvatar(
                      child:
                      Text(
                        '${e.quantity}',
                      ),
                    ),
                    title:
                    Text(
                      e.name,
                    ),
                    subtitle:
                    Text(
                      '${e.quantity} sold',
                    ),
                    trailing:
                    Text(
                      '₹${e.amount.toStringAsFixed(0)}',
                    ),
                  ),
                ),
              ],
            );
          },
          loading:
              () =>
          const CircularProgressIndicator(),
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