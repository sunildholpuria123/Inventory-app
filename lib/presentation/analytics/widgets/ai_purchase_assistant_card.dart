import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/ai_purchase_assistant_provider.dart';

class AiPurchaseAssistantCard
    extends ConsumerWidget {
  const AiPurchaseAssistantCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final data =
    ref.watch(
      aiPurchaseAssistantProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child:
        data.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text(
                'No Suggestions',
              );
            }

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'AI Purchase Assistant',
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
                    title:
                    Text(
                      e.productName,
                    ),
                    subtitle:
                    Text(
                      '${e.supplierName}\n'
                          'Need ${e.suggestedPurchase}',
                    ),
                    trailing:
                    Text(
                      '₹${e.estimatedCost.toStringAsFixed(0)}',
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