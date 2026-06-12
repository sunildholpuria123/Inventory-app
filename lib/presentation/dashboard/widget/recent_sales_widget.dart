import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class RecentSalesWidget extends ConsumerWidget {
  const RecentSalesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(recentSalesProvider);

    return Card(
      child: SizedBox(
        height: 250, // Fixed height

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Recent Sales',

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: sales.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('No Sales Found'));
                    }

                    return ListView.builder(
                      itemCount: items.length,

                      itemBuilder: (context, index) {
                        final sale = items[index];

                        return ListTile(
                          dense: true,

                          contentPadding: EdgeInsets.zero,

                          leading: const CircleAvatar(
                            radius: 18,

                            child: Icon(Icons.receipt, size: 18),
                          ),

                          title: Text(
                            sale.customerName,

                            overflow: TextOverflow.ellipsis,
                          ),

                          subtitle: Text(sale.invoiceNo),

                          trailing: Text(
                            '₹${sale.grandTotal.toStringAsFixed(0)}',

                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    );
                  },

                  loading: () =>
                      const Center(child: CircularProgressIndicator()),

                  error: (e, _) => Center(child: Text(e.toString())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
