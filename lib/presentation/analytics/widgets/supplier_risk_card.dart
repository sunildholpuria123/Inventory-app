import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_risk_provider.dart';

class SupplierRiskCard extends ConsumerWidget {
  const SupplierRiskCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final risks = ref.watch(supplierRiskProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: risks.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Supplier Data');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Supplier Risk Analysis',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                ...items
                    .take(5)
                    .map(
                      (e) => ListTile(
                        dense: true,
                        title: Text(e.supplierName),
                        subtitle: Text(e.riskLevel),
                        trailing: Text('${e.riskScore.toStringAsFixed(0)}%'),
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
