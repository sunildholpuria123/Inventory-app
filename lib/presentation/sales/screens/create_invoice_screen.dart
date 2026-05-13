import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/invoice_item_model.dart' show InvoiceItemModel;
import '../provider/invoice_item_provider.dart';
import '../provider/sales_provider.dart';
import '../provider/sales_repository_provider.dart';
import '../widgets/customer_dropdown.dart';
import '../widgets/invoice_product_list.dart';
import '../widgets/invoice_summary.dart';
import '../widgets/product_dropdown.dart';
import 'invoice_pdf_service.dart';

class CreateInvoiceScreen extends ConsumerWidget {
  const CreateInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String paymentMethod = 'CASH';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create Invoice',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    final customer = ref.read(
                      selectedCustomerProvider,
                    );

                    final items = ref.read(
                      invoiceItemsProvider,
                    );

                    final subtotal = ref.read(
                      subtotalProvider,
                    );

                    final tax = ref.read(
                      taxProvider,
                    );

                    final discount = ref.read(
                      discountProvider,
                    );

                    final total = ref.read(
                      grandTotalProvider,
                    );

                    final paymentMethod =
                    ref.read(
                      paymentMethodProvider,
                    );

                    if (customer == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Select Customer',
                          ),
                        ),
                      );

                      return;
                    }

                    if (items.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Add Products',
                          ),
                        ),
                      );

                      return;
                    }

                    /// INVOICE NUMBER
                    final invoiceNo =
                        'INV-${DateTime.now().millisecondsSinceEpoch}';

                    /// PDF
                    final pdfService =
                    InvoicePdfService();

                    final pdfPath =
                    await pdfService.generateInvoice(
                      invoiceNo: invoiceNo,

                      customerName:
                      customer.name,

                      customerPhone:
                      customer.phone,

                      items: items
                          .map(
                            (e) => InvoiceItemModel(
                          product: e.product,
                          qty: e.qty,
                          price: e.price,
                        ),
                      )
                          .toList(),

                      subtotal: subtotal,

                      tax: tax,

                      discount: discount,

                      grandTotal: total,

                      paymentMethod:
                      paymentMethod,
                    );

                    /// SAVE INVOICE
                    final repo = ref.read(
                      salesRepositoryProvider,
                    );

                    final invoiceId =
                    await repo.saveInvoice(
                      customerName:
                      customer.name,

                      customerPhone:
                      customer.phone,

                      subtotal: subtotal,

                      tax: tax,

                      discount: discount,

                      grandTotal: total,

                      paymentMethod:
                      paymentMethod,

                      pdfPath: pdfPath,
                    );

                    /// SAVE ITEMS
                    final invoiceItemRepo =
                    ref.read(
                      invoiceItemRepositoryProvider,
                    );

                    await invoiceItemRepo
                        .saveInvoiceItems(
                      invoiceId: invoiceId,

                      items: items,
                    );

                    /// CLEAR CART
                    ref
                        .read(
                      invoiceItemsProvider
                          .notifier,
                    )
                        .state = [];

                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invoice Saved',
                          ),
                        ),
                      );
                    }
                  },                  icon: const Icon(Icons.save),
                  label: const Text('Save Invoice'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Expanded(child: CustomerDropdown()),

                const SizedBox(width: 20),

                const Expanded(child: ProductDropdown()),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: paymentMethod,

                    decoration: const InputDecoration(
                      labelText: 'Payment Method',
                    ),

                    items: const [
                      DropdownMenuItem(value: 'CASH', child: Text('Cash')),

                      DropdownMenuItem(value: 'UPI', child: Text('UPI')),

                      DropdownMenuItem(value: 'CARD', child: Text('Card')),

                      DropdownMenuItem(
                        value: 'BANK',
                        child: Text('Bank Transfer'),
                      ),
                    ],

                    onChanged: (value) {
                      paymentMethod = value!;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Expanded(child: InvoiceProductList()),

            const SizedBox(height: 20),

            const InvoiceSummary(),
          ],
        ),
      ),
    );
  }
}
