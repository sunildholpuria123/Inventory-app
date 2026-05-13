import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/product_repository.dart';

import '../../products/provider/product_provider.dart' show productRepositoryProvider;
import '../model/invoice_item_model.dart';

import '../provider/invoice_item_provider.dart';
import '../provider/sales_provider.dart';
import '../provider/sales_repository_provider.dart';


import '../widgets/customer_dropdown.dart';
import '../widgets/invoice_product_list.dart';
import '../widgets/invoice_summary.dart';
import '../widgets/product_dropdown.dart';
import 'invoice_pdf_service.dart' show InvoicePdfService;

class CreateInvoiceScreen
    extends ConsumerStatefulWidget {
  const CreateInvoiceScreen({
    super.key,
  });

  @override
  ConsumerState<CreateInvoiceScreen>
  createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState
    extends ConsumerState<
        CreateInvoiceScreen> {
  bool isSaving = false;

  @override
  Widget build(
      BuildContext context,
      ) {
    final paymentMethod =
    ref.watch(
      paymentMethodProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Invoice',
        ),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            /// CUSTOMER
            const CustomerDropdown(),

            const SizedBox(
              height: 20,
            ),

            /// PRODUCT
            const ProductDropdown(),

            const SizedBox(
              height: 20,
            ),

            /// PRODUCT LIST
            const SizedBox(
              height: 300,

              child:
              InvoiceProductList(),
            ),

            const SizedBox(
              height: 20,
            ),

            /// PAYMENT METHOD
            DropdownButtonFormField<
                String>(
              value: paymentMethod,

              decoration:
              const InputDecoration(
                labelText:
                'Payment Method',
              ),

              items: const [
                DropdownMenuItem(
                  value: 'CASH',

                  child: Text(
                    'Cash',
                  ),
                ),

                DropdownMenuItem(
                  value: 'UPI',

                  child: Text(
                    'UPI',
                  ),
                ),

                DropdownMenuItem(
                  value: 'CARD',

                  child: Text(
                    'Card',
                  ),
                ),

                DropdownMenuItem(
                  value: 'BANK',

                  child: Text(
                    'Bank Transfer',
                  ),
                ),
              ],

              onChanged: (
                  value,
                  ) {
                if (value == null) {
                  return;
                }

                ref
                    .read(
                  paymentMethodProvider
                      .notifier,
                )
                    .state = value;
              },
            ),

            const SizedBox(
              height: 20,
            ),

            /// SUMMARY
            const InvoiceSummary(),

            const SizedBox(
              height: 20,
            ),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child:
              ElevatedButton.icon(
                onPressed:
                isSaving
                    ? null
                    : () async {
                  await saveInvoice();
                },

                icon:
                isSaving
                    ? const SizedBox(
                  width: 20,
                  height: 20,

                  child:
                  CircularProgressIndicator(
                    strokeWidth:
                    2,
                  ),
                )
                    : const Icon(
                  Icons.save,
                ),

                label: Text(
                  isSaving
                      ? 'Saving...'
                      : 'Generate Invoice',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveInvoice() async {
    try {
      setState(() {
        isSaving = true;
      });

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

      /// VALIDATION
      if (customer == null) {
        showMessage(
          'Select Customer',
        );

        return;
      }

      if (items.isEmpty) {
        showMessage(
          'Add Products',
        );

        return;
      }

      /// CHECK STOCK
      for (final item in items) {
        if (item.product.stockQty <
            item.qty) {
          showMessage(
            'Insufficient stock for ${item.product.name}',
          );

          return;
        }
      }

      /// INVOICE NUMBER
      final invoiceNo =
          'INV-${DateTime.now().millisecondsSinceEpoch}';

      /// GENERATE PDF
      final pdfService =
      InvoicePdfService();

      final pdfPath =
      await pdfService
          .generateInvoice(
        invoiceNo: invoiceNo,

        customerName:
        customer.name,

        customerPhone:
        customer.phone,

        items: items
            .map(
              (e) =>
              InvoiceItemModel(
                product:
                e.product,

                qty: e.qty,

                price:
                e.price,
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
      final salesRepo =
      ref.read(
        salesRepositoryProvider,
      );

      final invoiceId =
      await salesRepo
          .saveInvoice(
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

      /// SAVE INVOICE ITEMS
      final invoiceItemRepo =
      ref.read(
        invoiceItemRepositoryProvider,
      );

      await invoiceItemRepo
          .saveInvoiceItems(
        invoiceId: invoiceId,

        items: items,
      );

      /// UPDATE PRODUCT STOCK
      final productRepo =
      ref.read(
        productRepositoryProvider,
      );

      for (final item in items) {
        await productRepo
            .reduceStock(
          productId:
          item.product.id,

          qty: item.qty,
        );
      }

      /// CLEAR CART
      ref
          .read(
        invoiceItemsProvider
            .notifier,
      )
          .state = [];

      showMessage(
        'Invoice Saved Successfully',
      );
    } catch (e) {
      showMessage(
        e.toString(),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  void showMessage(
      String message,
      ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}