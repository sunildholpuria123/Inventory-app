import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/ai_sales_recommendation_provider.dart';

class AiSalesRecommendationWidget
    extends ConsumerWidget {
  const AiSalesRecommendationWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final recommendations =
    ref.watch(
      aiSalesRecommendationProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: recommendations.when(
          data: (items) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Recommendations',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 20),

                ...items.map(
                      (e) => ListTile(
                    contentPadding:
                    EdgeInsets.zero,
                    leading:
                    const Icon(
                      Icons
                          .lightbulb,
                    ),
                    title: Text(e),
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
              Text(e.toString()),
        ),
      ),
    );
  }
}