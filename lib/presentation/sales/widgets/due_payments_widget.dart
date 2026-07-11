import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_analytics_provider.dart';

class DuePaymentsWidget extends ConsumerWidget {
  const DuePaymentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final due = ref.watch(dueInvoicesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: due.when(
          data: (items) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due Payments',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ...items.map(
                  (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.customerName),
                    subtitle: Text(e.invoiceNo),
                    trailing: Text('₹${e.dueAmount.toStringAsFixed(0)}'),
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
