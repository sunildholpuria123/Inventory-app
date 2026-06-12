import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_ledger_provider.dart';
import '../widget/receive_payment_dialog.dart' show ReceivePaymentDialog;

class CustomerLedgerScreen extends ConsumerWidget {
  final Customer customer;

  const CustomerLedgerScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(customerLedgerProvider(customer.phone));

    return Scaffold(
      appBar: AppBar(title: Text('${customer.name} Ledger')),

      body: invoices.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Ledger Found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: items.length,

            itemBuilder: (context, index) {
              final invoice = items[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),

                child: ListTile(
                  title: Text(invoice.invoiceNo),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Status: ${invoice.paymentStatus}'),

                      Text('Due: ₹${invoice.dueAmount.toStringAsFixed(2)}'),

                      Text('Paid: ₹${invoice.amountPaid.toStringAsFixed(2)}'),
                    ],
                  ),

                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          '₹${invoice.grandTotal.toStringAsFixed(2)}',

                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        if (invoice.dueAmount > 0)

                          TextButton(
                            onPressed: () {

                              showDialog(
                                context: context,

                                builder: (_) =>
                                    ReceivePaymentDialog(
                                      invoice:
                                      invoice,

                                      customer:
                                      customer,
                                    ),
                              );
                            },

                            child:
                            const Text(
                              'Receive',
                            ),
                          )
                        else
                          const Text(
                            'Paid',

                            style: TextStyle(
                              color:
                              Colors.green,
                            ),
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
      ),
    );
  }
}
