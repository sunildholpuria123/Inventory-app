import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_history_provider.dart';
import '../provider/sales_repository_provider.dart';
import '../widgets/invoice_details_dialog.dart';

class SalesHistoryScreen extends ConsumerWidget {
  const SalesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(salesHistoryProvider);

    final mobile = MediaQuery
        .of(context)
        .size
        .width < 700;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales History',
            style: Theme
                .of(
              context,
            )
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Invoice...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onChanged: (value) {
                  ref
                      .read(salesSearchProvider.notifier)
                      .state = value;
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: invoices.when(
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text('No Sales Found'),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.refresh(salesHistoryProvider);
                  },
                  child: ListView.separated(
                    primary: false,
                    physics:
                    const BouncingScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final invoice = items[index];

                      return Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: mobile
                              ? _mobileCard(context, ref, invoice)
                              : _desktopCard(context, ref, invoice),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileCard(BuildContext context, WidgetRef ref, dynamic invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(child: Icon(Icons.receipt)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.customerName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(invoice.invoiceNo),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(invoice.createdAt.toString().substring(0, 16)),

        const SizedBox(height: 8),

        Text(
          '₹${invoice.grandTotal.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => InvoiceDetailsDialog(invoice: invoice),
                );
              },
              icon: const Icon(Icons.visibility),
            ),
            IconButton(
              onPressed: () async {
                final delete = await showDialog<bool>(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title: const Text('Delete Invoice'),
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                );

                if (delete != true) {
                  return;
                }

                final repo = ref.read(salesRepositoryProvider);

                await repo.restoreStockFromInvoice(invoice.id);

                await repo.deleteInvoice(invoice.id);

                ref.refresh(salesHistoryProvider);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _desktopCard(BuildContext context, WidgetRef ref, dynamic invoice) {
    return Row(
      children: [
        const CircleAvatar(radius: 28, child: Icon(Icons.receipt)),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.customerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(invoice.invoiceNo),
              Text(invoice.createdAt.toString().substring(0, 16)),
            ],
          ),
        ),

        Text(
          '₹${invoice.grandTotal.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),

        const SizedBox(width: 20),

        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => InvoiceDetailsDialog(invoice: invoice),
            );
          },
          icon: const Icon(Icons.visibility),
        ),

        IconButton(
          onPressed: () async {
            final repo = ref.read(salesRepositoryProvider);

            await repo.restoreStockFromInvoice(invoice.id);

            await repo.deleteInvoice(invoice.id);

            ref.refresh(salesHistoryProvider);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}
