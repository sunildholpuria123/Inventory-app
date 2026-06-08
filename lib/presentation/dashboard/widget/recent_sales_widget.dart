import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/dashboard_stats_provider.dart';

class RecentSalesWidget extends ConsumerWidget {
  const RecentSalesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(recentSalesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Recent Sales',

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            sales.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Text('No Sales Found');
                }

                return ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: items.length,

                  itemBuilder: (context, index) {
                    final sale = items[index];

                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.receipt)),

                      title: Text(sale.customerName),

                      subtitle: Text(sale.invoiceNo),

                      trailing: Text(
                        '₹${sale.grandTotal.toStringAsFixed(0)}',

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              },

              loading: () => const CircularProgressIndicator(),

              error: (e, _) => Text(e.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
