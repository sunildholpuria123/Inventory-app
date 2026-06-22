import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart'
    show productRepositoryProvider;
import '../../products/provider/product_variant_provider.dart';
import '../../settings/provider/settings_provider.dart';
import '../model/invoice_item_model.dart';
import '../provider/invoice_item_provider.dart';
import '../provider/sales_provider.dart';
import '../provider/sales_repository_provider.dart';
import '../widgets/customer_dropdown.dart';
import '../widgets/invoice_product_list.dart';
import '../widgets/invoice_summary.dart';
import '../widgets/product_dropdown.dart';
import 'invoice_pdf_service.dart' show InvoicePdfService;

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  ConsumerState<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final paymentMethod = ref.watch(paymentMethodProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Invoice')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// CUSTOMER
            const CustomerDropdown(),

            const SizedBox(height: 20),

            /// PRODUCT
            const ProductDropdown(),

            const SizedBox(height: 20),

            /// PRODUCT LIST
            const SizedBox(height: 300, child: InvoiceProductList()),

            const SizedBox(height: 20),

            /// PAYMENT METHOD
            DropdownButtonFormField<String>(
              value: paymentMethod,

              decoration: const InputDecoration(labelText: 'Payment Method'),

              items: const [
                DropdownMenuItem(value: 'CASH', child: Text('Cash')),

                DropdownMenuItem(value: 'UPI', child: Text('UPI')),

                DropdownMenuItem(value: 'CARD', child: Text('Card')),

                DropdownMenuItem(value: 'BANK', child: Text('Bank Transfer')),
              ],

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                ref.read(paymentMethodProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount Paid'),

              keyboardType: TextInputType.number,

              onChanged: (value) {
                ref.read(amountPaidProvider.notifier).state =
                    double.tryParse(value) ?? 0;
              },
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,

                  firstDate: DateTime.now(),

                  lastDate: DateTime(2100),

                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  ref.read(dueDateProvider.notifier).state = date;
                }
              },

              icon: const Icon(Icons.calendar_today),

              label: const Text('Due Date'),
            ),

            /// SUMMARY
            const InvoiceSummary(),

            const SizedBox(height: 20),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: isSaving
                    ? null
                    : () async {
                        await saveInvoice();
                      },

                icon: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,

                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),

                label: Text(isSaving ? 'Saving...' : 'Generate Invoice'),
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

      final customer = ref.read(selectedCustomerProvider);

      final items = ref.read(invoiceItemsProvider);

      final subtotal = ref.read(subtotalProvider);

      final tax = ref.read(taxProvider);

      final discount = ref.read(discountProvider);

      final total = ref.read(grandTotalProvider);

      final paymentMethod = ref.read(paymentMethodProvider);
      final amountPaid = ref.read(amountPaidProvider);

      final loadingCharge = ref.read(loadingChargeProvider);

      final unloadingCharge = ref.read(unloadingChargeProvider);

      final transportCharge = ref.read(transportChargeProvider);

      final dueDate = ref.read(dueDateProvider);
      final dueAmount = total - amountPaid;
      final paymentStatus = dueAmount <= 0
          ? 'PAID'
          : amountPaid == 0
          ? 'CREDIT'
          : 'PARTIAL';

      /// VALIDATION
      if (customer == null) {
        showMessage('Select Customer');

        return;
      }

      if (items.isEmpty) {
        showMessage('Add Products');

        return;
      }

      if (amountPaid > total) {
        showMessage('Paid amount cannot exceed total amount');

        return;
      }

      /// CHECK STOCK
      for (final item in items) {
        if (item.variant != null) {
          if (item.variant!.stockQty < item.quantity) {
            showMessage(
              'Insufficient stock for '
              '${item.displayName}',
            );

            return;
          }
        } else {
          if (item.product.stockQty < item.quantity) {
            showMessage(
              'Insufficient stock for '
              '${item.product.name}',
            );

            return;
          }
        }
      }

      /// INVOICE NUMBER
      final invoiceNo = 'INV-${DateTime.now().millisecondsSinceEpoch}';

      /// GENERATE PDF
      final pdfService = InvoicePdfService();
      final settingsRepo = ref.read(businessSettingsRepositoryProvider);

      final settings = await settingsRepo.getSettings();

      if (settings == null) {
        showMessage('Please configure Business Settings first');

        return;
      }

      final pdfPath = await pdfService.generateInvoice(
        invoiceNo: invoiceNo,

        customerName: customer.name,

        customerPhone: customer.phone,

        items: items
            .map(
              (e) => InvoiceItemModel(
                product: e.product,

                variantName: e.variant?.variantName,

                qty: e.quantity,

                price: e.unitPrice,

                height: e.height,

                width: e.width,

                area: e.isAreaBased ? e.area : null,
              ),
            )
            .toList(),

        subtotal: subtotal,

        tax: tax,

        discount: discount,

        grandTotal: total,

        paymentMethod: paymentMethod,

        amountPaid: amountPaid,

        dueAmount: dueAmount,

        paymentStatus: paymentStatus,
        businessSettings: settings,

        dueDate: dueDate,
        loadingCharge: loadingCharge,
        unloadingCharge: unloadingCharge,
        transportCharge: transportCharge,
      );

      /// SAVE INVOICE
      final salesRepo = ref.read(salesRepositoryProvider);

      final invoiceId = await salesRepo.saveInvoice(
        customerId: customer.id,

        customerName: customer.name,

        customerPhone: customer.phone,

        subtotal: subtotal,

        tax: tax,

        discount: discount,

        grandTotal: total,

        paymentMethod: paymentMethod,

        amountPaid: amountPaid,

        dueDate: dueDate,

        pdfPath: pdfPath,
      );

      /// SAVE INVOICE ITEMS
      final invoiceItemRepo = ref.read(invoiceItemRepositoryProvider);

      await invoiceItemRepo.saveInvoiceItems(
        invoiceId: invoiceId,

        items: items,
      );

      /// UPDATE STOCK

      final productRepo = ref.read(productRepositoryProvider);

      final variantRepo = ref.read(productVariantRepositoryProvider);

      for (final item in items) {
        if (item.variant != null) {
          await variantRepo.updateVariant(
            item.variant!.copyWith(
              stockQty: item.variant!.stockQty - item.quantity,
            ),
          );
        } else {
          await productRepo.reduceStock(
            productId: item.product.id,

            qty: item.quantity,
          );
        }
      }

      /// CLEAR CART
      ref.read(invoiceItemsProvider.notifier).state = [];
      ref.read(amountPaidProvider.notifier).state = 0;
      ref.read(loadingChargeProvider.notifier).state = 0;

      ref.read(unloadingChargeProvider.notifier).state = 0;

      ref.read(transportChargeProvider.notifier).state = 0;
      ref.read(dueDateProvider.notifier).state = null;
      ref.read(selectedCustomerProvider.notifier).state = null;

      showMessage('Invoice Saved Successfully');
    } catch (e) {
      showMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
