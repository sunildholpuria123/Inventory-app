import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_history_provider.dart';

import '../provider/sales_repository_provider.dart';

import '../widgets/invoice_details_dialog.dart' show InvoiceDetailsDialog;

class SalesHistoryScreen
    extends ConsumerWidget {
  const SalesHistoryScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final invoices =
    ref.watch(
      salesHistoryProvider,
    );

    return Scaffold(
      body: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [
            TextField(
              decoration:
              const InputDecoration(
                prefixIcon:
                Icon(Icons.search),

                hintText:
                'Search Invoice...',
              ),

              onChanged: (value) {
                ref
                    .read(
                  salesSearchProvider
                      .notifier,
                )
                    .state = value;
              },
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: invoices.when(
                data: (items) {
                  if (items
                      .isEmpty) {
                    return const Center(
                      child: Text(
                        'No Sales Found',
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount:
                    items.length,

                    itemBuilder: (
                        context,
                        index,
                        ) {
                      final invoice =
                      items[index];

                      return Card(
                        child: ListTile(
                          leading:
                          const CircleAvatar(
                            child: Icon(
                              Icons.receipt,
                            ),
                          ),

                          title: Text(
                            invoice
                                .customerName,
                          ),

                          subtitle:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [
                              Text(
                                invoice
                                    .invoiceNo,
                              ),

                              Text(
                                invoice
                                    .createdAt
                                    .toString(),
                              ),
                            ],
                          ),

                          trailing:
                          SizedBox(
                            width: 220,

                            child: Row(
                              children: [
                                Text(
                                  '₹${invoice.grandTotal.toStringAsFixed(0)}',
                                ),

                                IconButton(
                                  onPressed:
                                      () {
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

                                  icon:
                                  const Icon(
                                    Icons
                                        .visibility,
                                  ),
                                ),

                                IconButton(
                                  onPressed:
                                      () async {
                                    final repo =
                                    ref.read(
                                      salesRepositoryProvider,
                                    );

                                    await repo
                                        .restoreStockFromInvoice(
                                      invoice
                                          .id,
                                    );

                                    await repo
                                        .deleteInvoice(
                                      invoice
                                          .id,
                                    );

                                    ref.refresh(
                                      salesHistoryProvider,
                                    );
                                  },

                                  icon:
                                  const Icon(
                                    Icons
                                        .delete,

                                    color:
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },

                loading: () =>
                const Center(
                  child:
                  CircularProgressIndicator(),
                ),

                error: (e, _) =>
                    Center(
                      child: Text(
                        e.toString(),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}