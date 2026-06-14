import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/reminder_service.dart';
import '../../../data/database/app_database.dart';
import '../../dashboard/provider/dashboard_stats_provider.dart';

class DuePaymentsScreen extends ConsumerWidget {
  const DuePaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueInvoicesProvider);

    final upcoming = ref.watch(upcomingDueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Due Payments')),

      body: overdue.when(
        data: (overdueItems) {
          return upcoming.when(
            data: (upcomingItems) {
              if (overdueItems.isEmpty && upcomingItems.isEmpty) {
                return const Center(child: Text('No Due Payments'));
              }

              return ListView(
                padding: const EdgeInsets.only(bottom: 20),

                children: [
                  /// OVERDUE PAYMENTS
                  if (overdueItems.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16),

                      child: Text(
                        'Overdue Payments',

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,

                          color: Colors.red,
                        ),
                      ),
                    ),

                    ...overdueItems.map(
                      (invoice) =>
                          _buildInvoiceCard(context, invoice, isOverdue: true),
                    ),
                  ],

                  /// UPCOMING PAYMENTS
                  if (upcomingItems.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16),

                      child: Text(
                        'Upcoming Payments',

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,

                          color: Colors.orange,
                        ),
                      ),
                    ),

                    ...upcomingItems.map(
                      (invoice) =>
                          _buildInvoiceCard(context, invoice, isOverdue: false),
                    ),
                  ],
                ],
              );
            },

            loading: () => const Center(child: CircularProgressIndicator()),

            error: (e, _) => Center(child: Text(e.toString())),
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildInvoiceCard(
    BuildContext context,
    Invoice invoice, {
    required bool isOverdue,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Icon(
                  Icons.warning,

                  color: isOverdue ? Colors.red : Colors.orange,
                ),

                const SizedBox(width: 12),

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

                      const SizedBox(height: 4),

                      Text(
                        invoice.invoiceNo,

                        maxLines: 2,

                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Due Date: ${invoice.dueDate?.toString().split(' ').first ?? 'N/A'}',
                      ),

                      Text(
                        isOverdue ? 'Status: OVERDUE' : 'Status: UPCOMING',

                        style: TextStyle(
                          color: isOverdue ? Colors.red : Colors.orange,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(
                      'Rs.${invoice.dueAmount.toStringAsFixed(0)}',

                      style: const TextStyle(
                        fontSize: 18,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text('${invoice.paymentStatus}'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.message),

                  label: const Text('WhatsApp'),

                  onPressed: () async {
                    await ReminderService.sendWhatsAppReminder(
                      phone: invoice.customerPhone,

                      customerName: invoice.customerName,

                      amount: invoice.dueAmount,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
