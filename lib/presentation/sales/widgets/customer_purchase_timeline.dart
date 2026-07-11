import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_history_provider.dart';

class CustomerPurchaseTimeline extends ConsumerWidget {
  final String customerName;

  const CustomerPurchaseTimeline({super.key, required this.customerName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(salesHistoryProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: invoices.when(
          data: (items) {
            final customerInvoices =
                items.where((e) => e.customerName == customerName).toList()
                  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase Timeline',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ...customerInvoices.map(
                  (invoice) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.receipt_long),
                    title: Text(invoice.invoiceNo),
                    subtitle: Text(
                      invoice.createdAt.toString().substring(0, 16),
                    ),
                    trailing: Text('₹${invoice.grandTotal.toStringAsFixed(0)}'),
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
