import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_provider.dart';

class InvoiceSummary extends ConsumerStatefulWidget {
  const InvoiceSummary({super.key});

  @override
  ConsumerState<InvoiceSummary> createState() => _InvoiceSummaryState();
}

class _InvoiceSummaryState extends ConsumerState<InvoiceSummary> {
  late final TextEditingController discountController;

  late final TextEditingController taxController;

  late final TextEditingController loadingController;
  late final TextEditingController unloadingController;
  late final TextEditingController transportController;

  @override
  void initState() {
    super.initState();

    discountController = TextEditingController();

    taxController = TextEditingController(text: '0');

    loadingController = TextEditingController();

    unloadingController = TextEditingController();

    transportController = TextEditingController();
  }

  @override
  void dispose() {
    discountController.dispose();

    taxController.dispose();
    loadingController.dispose();
    unloadingController.dispose();
    transportController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = ref.watch(subtotalProvider);

    final tax = ref.watch(taxProvider);

    final grandTotal = ref.watch(grandTotalProvider);
    final loading = ref.watch(loadingChargeProvider);

    final unloading = ref.watch(unloadingChargeProvider);

    final transport = ref.watch(transportChargeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: discountController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(labelText: 'Discount'),

                    onChanged: (value) {
                      ref.read(discountProvider.notifier).state =
                          double.tryParse(value) ?? 0;
                    },
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: TextField(
                    controller: taxController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(labelText: 'GST %'),

                    onChanged: (value) {
                      ref.read(taxPercentProvider.notifier).state =
                          double.tryParse(value) ?? 0;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ExpansionTile(
              title: const Text('Additional Charges'),

              childrenPadding: const EdgeInsets.all(12),

              children: [
                TextField(
                  controller: loadingController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Loading Charges',
                  ),

                  onChanged: (value) {
                    ref.read(loadingChargeProvider.notifier).state =
                        double.tryParse(value) ?? 0;
                  },
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: unloadingController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Unloading Charges',
                  ),

                  onChanged: (value) {
                    ref.read(unloadingChargeProvider.notifier).state =
                        double.tryParse(value) ?? 0;
                  },
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: transportController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Transport Charges',
                  ),

                  onChanged: (value) {
                    ref.read(transportChargeProvider.notifier).state =
                        double.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            buildRow('Subtotal', subtotal),

            const SizedBox(height: 10),

            buildRow('GST', tax),

            const Divider(height: 30),
            if (loading > 0) buildRow('Loading Charges', loading),

            if (unloading > 0) buildRow('Unloading Charges', unloading),

            if (transport > 0) buildRow('Transport Charges', transport),

            buildRow('Grand Total', grandTotal, bold: true),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            fontSize: bold ? 18 : 16,

            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        Text(
          'Rs.${value.toStringAsFixed(2)}',

          style: TextStyle(
            fontSize: bold ? 20 : 18,

            fontWeight: FontWeight.bold,

            color: bold ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}
