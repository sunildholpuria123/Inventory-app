import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/invoice_item_model.dart' show InvoiceItemModel;
import '../provider/sales_provider.dart';
import '../widgets/customer_dropdown.dart';
import '../widgets/invoice_product_list.dart';
import '../widgets/invoice_summary.dart';
import '../widgets/product_dropdown.dart';
import 'invoice_pdf_service.dart';
class CreateInvoiceScreen
    extends ConsumerWidget {
  const CreateInvoiceScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text(
                  'Create Invoice',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    final customer = ref.read(
                      selectedCustomerProvider,
                    );

                    final items = ref.read(
                      invoiceItemsProvider,
                    );

                    final total = ref.read(
                      grandTotalProvider,
                    );

                    // Validate customer
                    if (customer == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Select customer',
                          ),
                        ),
                      );

                      return;
                    }

                    // Validate products
                    if (items.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Add products',
                          ),
                        ),
                      );

                      return;
                    }

                    // Save invoice in database
                    final repo = ref.read(
                      salesRepositoryProvider,
                    );

                    await repo.saveInvoice(
                      customerId: customer.id,
                      items: items,
                      total: total,
                    );

                    // Generate PDF
                    final pdfService =
                    InvoicePdfService();

                    await pdfService.generateInvoice(
                      invoiceNo:
                      'INV-${DateTime.now().millisecondsSinceEpoch}',

                      customerName: customer.name,

                      customerPhone: customer.phone,

                      items: items
                          .map(
                            (e) => InvoiceItemModel(
                          name: e.product.name,
                          qty: e.qty,
                          price: e.price,
                          subtotal: e.subtotal,
                        ),F
                      )
                          .toList(),

                      subtotal: ref.read(
                        subtotalProvider,
                      ),

                      tax: ref.read(
                        taxProvider,
                      ),

                      discount: ref.read(
                        discountProvider,
                      ),

                      grandTotal: total,
                    );

                    // Clear cart
                    ref
                        .read(
                      invoiceItemsProvider.notifier,
                    )
                        .state = [];

                    // Success message
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invoice Saved Successfully',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                  ),
                  label: const Text(
                    'Save Invoice',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Expanded(
                  child:
                  CustomerDropdown(),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: ProductDropdown(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Expanded(
              child: InvoiceProductList(),
            ),

            const SizedBox(height: 20),

            const InvoiceSummary(),
          ],
        ),
      ),
    );
  }
}