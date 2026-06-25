import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';
import '../widgets/payment_status_badge.dart';

class InvoiceDetailsDialog extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailsDialog({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.of(context)
            .size
            .width <
            700;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.receipt_long,
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Text(
              invoice.invoiceNo,
            ),
          ),
        ],
      ),

      content: SizedBox(
        width: mobile ? 350 : 550,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,

                child: Padding(
                  padding:
                  const EdgeInsets.all(
                    16,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      Text(
                        'Customer Information',

                        style:
                        Theme.of(
                          context,
                        )
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const Divider(),

                      _buildRow(
                        'Customer',
                        invoice.customerName,
                      ),

                      _buildRow(
                        'Phone',
                        invoice.customerPhone,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              Card(
                elevation: 0,

                child: Padding(
                  padding:
                  const EdgeInsets.all(
                    16,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      Text(
                        'Payment Details',

                        style:
                        Theme.of(
                          context,
                        )
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const Divider(),

                      _buildRow(
                        'Subtotal',
                        '₹${invoice.subtotal.toStringAsFixed(2)}',
                      ),

                      _buildRow(
                        'Tax',
                        '₹${invoice.tax.toStringAsFixed(2)}',
                      ),

                      _buildRow(
                        'Discount',
                        '₹${invoice.discount.toStringAsFixed(2)}',
                      ),

                      _buildRow(
                        'Grand Total',
                        '₹${invoice.grandTotal.toStringAsFixed(2)}',
                        bold: true,
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      _buildRow(
                        'Payment Method',
                        invoice.paymentMethod,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [
                          const Text(
                            'Status',
                          ),

                          const Spacer(),

                          PaymentStatusBadge(
                            status:
                            invoice.paymentStatus,
                          ),
                        ],
                      ),

                      if (invoice.amountPaid !=
                          null) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        _buildRow(
                          'Amount Paid',
                          '₹${invoice.amountPaid!.toStringAsFixed(2)}',
                        ),
                      ],

                      if (invoice.dueAmount !=
                          null) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        _buildRow(
                          'Due Amount',
                          '₹${invoice.dueAmount!.toStringAsFixed(2)}',
                        ),
                      ],

                      if (invoice.dueDate !=
                          null) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        _buildRow(
                          'Due Date',
                          invoice.dueDate!
                              .toString()
                              .substring(
                            0,
                            10,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              if (invoice.pdfPath !=
                  null)
                SizedBox(
                  width:
                  double.infinity,

                  child:
                  FilledButton.icon(
                    onPressed:
                        () async {
                      final file =
                      File(
                        invoice.pdfPath!,
                      );

                      if (await file
                          .exists()) {
                        Process.run(
                          'explorer',
                          [
                            file.path,
                          ],
                        );
                      }
                    },

                    icon:
                    const Icon(
                      Icons.picture_as_pdf,
                    ),

                    label:
                    const Text(
                      'Open Invoice PDF',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),

      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },

          child: const Text(
            'Close',
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
      String title,
      String value, {
        bool bold = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontWeight:
              bold
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}