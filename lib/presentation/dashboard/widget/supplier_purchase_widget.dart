import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../purchases/provider/purchase_stats_provider.dart';

class SupplierPurchaseWidget extends ConsumerWidget {
  const SupplierPurchaseWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesBySupplier = ref.watch(purchasesBySupplierProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              'Top Suppliers',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            purchasesBySupplier.when(
              data: (suppliers) {
                if (suppliers.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),

                    child: Center(child: Text('No Purchase Data')),
                  );
                }

                final sortedSuppliers = suppliers.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return ListView.separated(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: sortedSuppliers.length > 5
                      ? 5
                      : sortedSuppliers.length,

                  separatorBuilder: (_, __) => const Divider(),

                  itemBuilder: (context, index) {
                    final supplier = sortedSuppliers[index];

                    return ListTile(
                      dense: true,

                      leading: CircleAvatar(child: Text('${index + 1}')),

                      title: Text(
                        supplier.key,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,
                      ),

                      subtitle: const Text('Purchases'),

                      trailing: Text(
                        '₹${supplier.value.toStringAsFixed(0)}',

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              },

              loading: () => const Padding(
                padding: EdgeInsets.all(20),

                child: Center(child: CircularProgressIndicator()),
              ),

              error: (error, _) => Padding(
                padding: const EdgeInsets.all(20),

                child: Center(child: Text(error.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
