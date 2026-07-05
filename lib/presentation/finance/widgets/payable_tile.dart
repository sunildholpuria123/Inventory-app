import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../suppliers/screens/supplier_ledger_screen.dart';
import '../../suppliers/widgets/supplier_payment_dialog.dart';
import '../model/payable_data.dart';
import '../provider/payables_provider.dart';

class PayableTile extends ConsumerWidget {
  final PayableData item;

  const PayableTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplier = item.supplier;

    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(
            Icons.factory,
          ),
        ),
        title: Text(
          supplier.name,
        ),
        subtitle: Text(
          'Due ₹${item.amount.toStringAsFixed(0)}',
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              tooltip: 'Pay',
              icon: const Icon(
                Icons.payments,
                color: Colors.green,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) =>
                      SupplierPaymentDialog(
                        supplier: supplier,
                      ),
                );

                ref.invalidate(
                  payablesProvider,
                );
              },
            ),            IconButton(
              tooltip: 'Ledger',
              icon: const Icon(
                Icons.receipt_long,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SupplierLedgerScreen(
                          supplier: supplier,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}