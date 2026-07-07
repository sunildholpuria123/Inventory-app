import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class TopProductsWidget extends ConsumerWidget {
  const TopProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(topProductsProvider);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: products.when(
          loading: () => const SizedBox(
            height: 220,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => SizedBox(
            height: 220,
            child: Center(
              child: Text(e.toString()),
            ),
          ),
          data: (items) {
            if (items.isEmpty) {
              return const SizedBox(
                height: 220,
                child: Center(
                  child: Text("No sales available"),
                ),
              );
            }

            final maxRevenue = items
                .map((e) => e.revenue)
                .reduce((a, b) => a > b ? a : b);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Selling Products",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Best performing products based on sales",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
                  itemBuilder: (_, index) {
                    final product = items[index];

                    final progress =
                    maxRevenue == 0 ? 0.0 : product.revenue / maxRevenue;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                            child: Text(
                              "#${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  maxLines: 1,
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
                                  "Sold: ${product.totalQty}",
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),

                                const SizedBox(height: 10),

                                LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Revenue",
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "₹${product.revenue.toStringAsFixed(0)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}