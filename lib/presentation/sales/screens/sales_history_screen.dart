import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_history_provider.dart';
import '../provider/sales_repository_provider.dart';
import '../widgets/invoice_details_dialog.dart' show InvoiceDetailsDialog;

class SalesHistoryScreen extends ConsumerWidget {
  const SalesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(salesHistoryProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),

                hintText: 'Search Invoice...',
              ),

              onChanged: (value) {
                ref.read(salesSearchProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: invoices.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(child: Text('No Sales Found'));
                  }

                  return ListView.builder(
                    itemCount: items.length,

                    itemBuilder: (context, index) {
                      final invoice = items[index];

                       return Card(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const CircleAvatar(
                                child: Icon(
                                  Icons.receipt,
                                ),
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      invoice.customerName,

                                      maxLines: 1,

                                      overflow:
                                      TextOverflow.ellipsis,

                                      style:
                                      const TextStyle(
                                        fontWeight:
                                        FontWeight.bold,

                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 4,
                                    ),

                                    Text(
                                      invoice.invoiceNo,

                                      maxLines: 2,

                                      overflow:
                                      TextOverflow.ellipsis,

                                      style:
                                      TextStyle(
                                        color:
                                        Colors.grey[700],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 4,
                                    ),

                                    Text(
                                      invoice.createdAt
                                          .toString()
                                          .substring(
                                        0,
                                        16,
                                      ),

                                      style:
                                      TextStyle(
                                        color:
                                        Colors.grey[600],

                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,

                                children: [

                                  Text(
                                    'Rs.${invoice.grandTotal.toStringAsFixed(0)}',

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Row(
                                    mainAxisSize:
                                    MainAxisSize.min,

                                    children: [

                                      IconButton(
                                        visualDensity:
                                        VisualDensity.compact,

                                        constraints:
                                        const BoxConstraints(),

                                        onPressed: () {
                                          showDialog(
                                            context:
                                            context,

                                            builder:
                                                (_) =>
                                                InvoiceDetailsDialog(
                                                  invoice:
                                                  invoice,
                                                ),
                                          );
                                        },

                                        icon: const Icon(
                                          Icons.visibility,

                                          color:
                                          Colors.grey,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      IconButton(
                                        visualDensity:
                                        VisualDensity.compact,

                                        constraints:
                                        const BoxConstraints(),

                                        onPressed:
                                            () async {

                                          final repo =
                                          ref.read(
                                            salesRepositoryProvider,
                                          );

                                          await repo
                                              .restoreStockFromInvoice(
                                            invoice.id,
                                          );

                                          await repo
                                              .deleteInvoice(
                                            invoice.id,
                                          );

                                          ref.refresh(
                                            salesHistoryProvider,
                                          );
                                        },

                                        icon: const Icon(
                                          Icons.delete,

                                          color:
                                          Colors.red,
                                        ),
                                      ),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
