import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_analytics_provider.dart';

class TopCustomersWidget extends ConsumerWidget {
  const TopCustomersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(topCustomersProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: customers.when(
          data: (items) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Customers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ...items.map(
                  (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.customer),
                    trailing: Text('₹${e.amount.toStringAsFixed(0)}'),
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
