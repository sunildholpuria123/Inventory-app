import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_score_provider.dart';

class SupplierScoreCard
    extends ConsumerWidget {
  const SupplierScoreCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final scores =
    ref.watch(
      supplierScoreProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child:
        scores.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text(
                'No Supplier Data',
              );
            }

            final top =
                items.first;

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Supplier',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  top.supplierName,
                ),
                Text(
                  '${top.score.toStringAsFixed(0)}/100',
                ),
              ],
            );
          },
          loading:
              () =>
          const CircularProgressIndicator(),
          error:
              (_, __) =>
          const Text('Error'),
        ),
      ),
    );
  }
}