import 'package:flutter/material.dart'
    show
        BuildContext,
        Widget,
        Text,
        Icon,
        Center,
        AppBar,
        ListView,
        Icons,
        Colors,
        ListTile,
        Card,
        CircularProgressIndicator,
        Scaffold,
        Padding,
        EdgeInsets,
        SizedBox,
        TextStyle,
        CrossAxisAlignment,
        FontWeight,
        TextOverflow,
        Column,
        Expanded,
        Row,
        MainAxisAlignment,
        OutlinedButton;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef, AsyncValueX;

import '../../../core/services/reminder_service.dart' show ReminderService;
import '../../dashboard/provider/dashboard_stats_provider.dart'
    show overdueInvoicesProvider;

class DuePaymentsScreen extends ConsumerWidget {
  const DuePaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueInvoicesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Due Payments')),

      body: overdue.when(
        data: (items) {
          return ListView.builder(
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
                      Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.red),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  invoice.customerName,

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  invoice.invoiceNo,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,
                                ),

                                Text(
                                  'Due: ${invoice.dueDate?.toString().split(' ').first ?? 'N/A'}',
                                ),
                              ],
                            ),
                          ),

                          Text(
                            '₹${invoice.dueAmount.toStringAsFixed(0)}',

                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.message),

                            label: const Text('Remind'),

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
            },
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
