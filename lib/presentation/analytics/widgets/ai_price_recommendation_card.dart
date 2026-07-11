import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/price_recommendation_provider.dart';

class AiPriceRecommendationCard
    extends ConsumerWidget {
  const AiPriceRecommendationCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final recommendations = ref.watch(
      priceRecommendationProvider,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: recommendations.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text(
                'No Price Data',
              );
            }

            final item = items.first;

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Price Recommendation',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 20),

                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Current Purchase : ₹${item.currentPurchase.toStringAsFixed(2)}',
                ),

                Text(
                  'Recommended Purchase : ₹${item.recommendedPurchase.toStringAsFixed(2)}',
                ),

                Text(
                  'Recommended Selling : ₹${item.recommendedSelling.toStringAsFixed(2)}',
                ),
              ],
            );
          },
          loading: () => const Center(
            child:
            CircularProgressIndicator(),
          ),
          error: (e, _) =>
              Text(e.toString()),
        ),
      ),
    );
  }
}