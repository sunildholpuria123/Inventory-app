import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_provider.dart';

class InvoiceSummary
    extends ConsumerStatefulWidget {
  const InvoiceSummary({
    super.key,
  });

  @override
  ConsumerState<InvoiceSummary>
  createState() =>
      _InvoiceSummaryState();
}

class _InvoiceSummaryState
    extends ConsumerState<
        InvoiceSummary> {
  late final TextEditingController
  discountController;

  late final TextEditingController
  taxController;

  @override
  void initState() {
    super.initState();

    discountController =
        TextEditingController();

    taxController =
        TextEditingController(
          text: '0',
        );
  }

  @override
  void dispose() {
    discountController.dispose();

    taxController.dispose();

    super.dispose();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final subtotal = ref.watch(
      subtotalProvider,
    );

    final tax = ref.watch(
      taxProvider,
    );

    final grandTotal = ref.watch(
      grandTotalProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

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

                    onChanged: (
                        value,
                        ) {
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

                const SizedBox(
                  width: 20,
                ),

                Expanded(
                  child: TextField(
                    controller:
                    taxController,

                    keyboardType:
                    TextInputType
                        .number,

                    decoration:
                    const InputDecoration(
                      labelText:
                      'GST %',
                    ),

                    onChanged: (
                        value,
                        ) {
                      ref
                          .read(
                        taxPercentProvider
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

            const SizedBox(
              height: 25,
            ),

            buildRow(
              'Subtotal',
              subtotal,
            ),

            const SizedBox(
              height: 10,
            ),

            buildRow(
              'GST',
              tax,
            ),

            const Divider(
              height: 30,
            ),

            buildRow(
              'Grand Total',
              grandTotal,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
      String title,
      double value, {
        bool bold = false,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment
          .spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            fontSize:
            bold ? 18 : 16,

            fontWeight:
            bold
                ? FontWeight
                .bold
                : FontWeight
                .normal,
          ),
        ),

        Text(
          '₹${value.toStringAsFixed(2)}',

          style: TextStyle(
            fontSize:
            bold ? 20 : 18,

            fontWeight:
            FontWeight.bold,

            color:
            bold
                ? Colors.green
                : null,
          ),
        ),
      ],
    );
  }
}