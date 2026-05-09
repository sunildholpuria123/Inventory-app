import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_provider.dart';

class InvoiceSummary
    extends ConsumerWidget {
  const InvoiceSummary({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final subtotal =
    ref.watch(subtotalProvider);

    final grandTotal =
    ref.watch(grandTotalProvider);

    final discountController =
    TextEditingController();

    final taxController =
    TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                    discountController,

                    keyboardType:
                    TextInputType
                        .number,

                    decoration:
                    const InputDecoration(
                      labelText:
                      'Discount',
                    ),

                    onChanged: (value) {
                      ref
                          .read(
                        discountProvider
                            .notifier,
                      )
                          .state = double.tryParse(
                        value,
                      ) ??
                          0;
                    },
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: TextField(
                    controller:
                    taxController,

                    keyboardType:
                    TextInputType
                        .number,

                    decoration:
                    const InputDecoration(
                      labelText: 'GST',
                    ),

                    onChanged: (value) {
                      ref
                          .read(
                        taxProvider
                            .notifier,
                      )
                          .state = double.tryParse(
                        value,
                      ) ??
                          0;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            buildRow(
              'Subtotal',
              subtotal,
            ),

            const SizedBox(height: 10),

            buildRow(
              'Grand Total',
              grandTotal,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
      String title,
      double value,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(title),

        Text(
          '₹${value.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ],
    );
  }
}