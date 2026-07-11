import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../sales/widgets/invoice_details_dialog.dart';
import '../provider/customer_provider.dart';
import 'payment_history_dialog.dart';
import 'receive_payment_dialog.dart';

class CustomerInvoicesTab extends ConsumerWidget {
  final Customer customer;

  const CustomerInvoicesTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(customerInvoicesProvider(customer.id));
    return invoices.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('No Invoices'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: items.length,
          itemBuilder: (_, index) {
            final invoice = items[index];

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(invoice.invoiceNo.substring(0, 2)),
                ),

                title: Text(invoice.invoiceNo),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice.createdAt.toString().substring(0, 16)),

                    Text('Status : ${invoice.paymentStatus}'),

                    if (invoice.dueAmount > 0)
                      Text(
                        'Due : ₹${invoice.dueAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),

                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'View',
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              InvoiceDetailsDialog(invoice: invoice),
                        );
                      },
                    ),

                    IconButton(
                      tooltip: 'Payment History',
                      icon: const Icon(Icons.history, color: Colors.orange),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              PaymentHistoryDialog(invoiceId: invoice.id),
                        );
                      },
                    ),

                    if (invoice.dueAmount > 0)
                      IconButton(
                        tooltip: 'Receive Payment',
                        icon: const Icon(Icons.payments, color: Colors.green),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ReceivePaymentDialog(
                              invoice: invoice,
                              customer: customer,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}
