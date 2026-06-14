import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/reminder_service.dart' show ReminderService;
import '../../../data/database/app_database.dart';
import '../provider/customer_ledger_provider.dart';
import '../widget/payment_history_dialog.dart' show PaymentHistoryDialog;
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
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// TOP ROW
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  invoice.invoiceNo,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text('Status: ${invoice.paymentStatus}'),

                                Text(
                                  'Due: Rs.${invoice.dueAmount.toStringAsFixed(2)}',
                                ),

                                Text(
                                  'Paid: Rs.${invoice.amountPaid.toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            'Rs.${invoice.grandTotal.toStringAsFixed(2)}',

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,

                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// ACTIONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          if (invoice.dueAmount > 0)
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,

                                  builder: (_) => ReceivePaymentDialog(
                                    invoice: invoice,

                                    customer: customer,
                                  ),
                                );
                              },

                              child: const Text('Receive'),
                            ),

                          if (invoice.dueAmount > 0)
                            IconButton(
                              tooltip: 'Send Reminder',

                              icon: const Icon(
                                Icons.notifications_active,

                                color: Colors.orange,
                              ),

                              onPressed: () async {
                                await ReminderService.sendWhatsAppReminder(
                                  phone: invoice.customerPhone,

                                  customerName: invoice.customerName,

                                  amount: invoice.dueAmount,
                                );
                              },
                            ),

                          IconButton(
                            tooltip: 'Payment History',

                            icon: const Icon(Icons.history),

                            onPressed: () {
                              showDialog(
                                context: context,

                                builder: (_) =>
                                    PaymentHistoryDialog(invoiceId: invoice.id),
                              );
                            },
                          ),
                        ],
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
