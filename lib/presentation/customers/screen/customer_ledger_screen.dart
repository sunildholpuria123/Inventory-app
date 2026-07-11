import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/reminder_service.dart';
import '../../../data/database/app_database.dart';
import '../provider/customer_ledger_provider.dart';
import '../widget/payment_history_dialog.dart';
import '../widget/receive_payment_dialog.dart';

class CustomerLedgerScreen extends ConsumerWidget {
  final Customer customer;

  const CustomerLedgerScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(customerLedgerProvider(customer.phone));

    return Scaffold(
      appBar: AppBar(title: Text('${customer.name} Ledger')),
      body: invoices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text("No Ledger Found"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final invoice = items[index];

              final statusColor = invoice.dueAmount > 0
                  ? Colors.orange
                  : Colors.green;

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// HEADER
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  invoice.invoiceNo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    invoice.paymentStatus,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "₹${invoice.grandTotal.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: _AmountCard(
                              title: "Due",
                              value: invoice.dueAmount,
                              color: Colors.red,
                              icon: Icons.warning,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _AmountCard(
                              title: "Paid",
                              value: invoice.amountPaid,
                              color: Colors.green,
                              icon: Icons.check_circle,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      if (invoice.grandTotal > 0)
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                minHeight: 8,
                                value: invoice.amountPaid / invoice.grandTotal,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${((invoice.amountPaid / invoice.grandTotal) * 100).toStringAsFixed(0)}% Paid",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.end,
                        children: [
                          if (invoice.dueAmount > 0)
                            FilledButton.icon(
                              icon: const Icon(Icons.payments),
                              label: const Text("Receive"),
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

                          IconButton.filledTonal(
                            tooltip: "Reminder",
                            icon: const Icon(Icons.notifications_active),
                            onPressed: () async {
                              await ReminderService.sendWhatsAppReminder(
                                phone: invoice.customerPhone,
                                customerName: invoice.customerName,
                                amount: invoice.dueAmount,
                              );
                            },
                          ),

                          IconButton.filledTonal(
                            tooltip: "History",
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
      ),
    );
  }
}

class _AmountCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;
  final IconData icon;

  const _AmountCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color, size: 18),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(
                  "₹${value.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
