import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

class InvoiceDetailsDialog extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailsDialog({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(invoice.invoiceNo),

      content: SizedBox(
        width: 500,

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            buildRow('Customer', invoice.customerName),

            buildRow('Phone', invoice.customerPhone),

            buildRow('Subtotal', '₹${invoice.subtotal}'),

            buildRow('Tax', '₹${invoice.tax}'),

            buildRow('Discount', '₹${invoice.discount}'),

            buildRow('Grand Total', '₹${invoice.grandTotal}'),

            buildRow('Payment', invoice.paymentMethod),

            const SizedBox(height: 20),

            if (invoice.pdfPath != null)
              ElevatedButton.icon(
                onPressed: () async {
                  final file = File(invoice.pdfPath!);

                  if (await file.exists()) {
                    Process.run('explorer', [file.path]);
                  }
                },

                icon: const Icon(Icons.picture_as_pdf),

                label: const Text('Open PDF'),
              ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title),

          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
