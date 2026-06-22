import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/demand_prediction_provider.dart';

class DemandPredictionCard extends ConsumerWidget {
  const DemandPredictionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prediction = ref.watch(demandPredictionProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: prediction.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Sales Data');
            }

            final top = items.first;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most Demanded Product',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                Text(top.productName),

                Text('${top.predictedQty} sold'),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text('Error'),
        ),
      ),
    );
  }
}
