import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/supplier_provider.dart';

class SupplierPaymentDialog extends ConsumerStatefulWidget {
  final Supplier supplier;

  const SupplierPaymentDialog({super.key, required this.supplier});

  @override
  ConsumerState<SupplierPaymentDialog> createState() =>
      _SupplierPaymentDialogState();
}

class _SupplierPaymentDialogState extends ConsumerState<SupplierPaymentDialog> {
  final amountController = TextEditingController();

  String paymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Supplier Payment'),

      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Text(
            'Outstanding: '
            '₹${widget.supplier.creditBalance.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 16),

          TextField(
            controller: amountController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(labelText: 'Amount'),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: paymentMethod,

            items: const [
              DropdownMenuItem(value: 'Cash', child: Text('Cash')),

              DropdownMenuItem(value: 'UPI', child: Text('UPI')),

              DropdownMenuItem(value: 'Bank', child: Text('Bank')),
            ],

            onChanged: (value) {
              paymentMethod = value!;
            },
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () async {
            final amount = double.tryParse(amountController.text) ?? 0;

            if (amount <= 0 || amount > widget.supplier.creditBalance) {
              return;
            }

            final repo = ref.read(supplierRepositoryProvider);

            await repo.makeSupplierPayment(
              supplierId: widget.supplier.id,

              amount: amount,

              paymentMethod: paymentMethod,
            );

            if (context.mounted) {
              Navigator.pop(context);
            }
          },

          child: const Text('Pay'),
        ),
      ],
    );
  }
}
