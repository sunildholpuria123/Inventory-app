import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_recommendation_provider.dart';

class SupplierRecommendationCard extends ConsumerWidget {
  const SupplierRecommendationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliers = ref.watch(supplierRecommendationProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: suppliers.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Supplier Data');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Suppliers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                ...items
                    .take(5)
                    .map(
                      (e) => ListTile(
                        dense: true,
                        title: Text(e.supplierName),
                        trailing: Text('${e.score.toStringAsFixed(0)}/100'),
                      ),
                    ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text(e.toString()),
        ),
      ),
    );
  }
}
