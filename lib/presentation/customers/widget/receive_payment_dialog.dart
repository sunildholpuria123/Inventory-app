import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../dashboard/provider/dashboard_provider.dart' show revenueProvider;
import '../../dashboard/provider/dashboard_stats_provider.dart' show profitSummaryProvider, recentSalesProvider;
import '../../dashboard/provider/outstanding_provider.dart' show outstandingProvider;
import '../provider/customer_ledger_provider.dart' show customerLedgerProvider;
import '../provider/payment_history_provider.dart' show paymentHistoryProvider;

class ReceivePaymentDialog extends ConsumerStatefulWidget {
  final Invoice invoice;
  final Customer customer;

  const ReceivePaymentDialog({
    super.key,
    required this.invoice,
    required this.customer,
  });

  @override
  ConsumerState<ReceivePaymentDialog> createState() =>
      _ReceivePaymentDialogState();
}

class _ReceivePaymentDialogState extends ConsumerState<ReceivePaymentDialog> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> _receivePayment() async {
    final amount = double.tryParse(amountController.text) ?? 0;

    if (amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter valid amount')));

      return;
    }

    if (amount > widget.invoice.dueAmount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount exceeds due balance')),
      );

      return;
    }

    final db = ref.read(databaseProvider);

    final newPaid = widget.invoice.amountPaid + amount;

    final newDue = widget.invoice.dueAmount - amount;

    final newStatus = newDue <= 0 ? 'PAID' : 'PARTIAL';

    await (db.update(
      db.invoices,
    )..where((tbl) => tbl.id.equals(widget.invoice.id))).write(
      InvoicesCompanion(
        amountPaid: Value(newPaid),

        dueAmount: Value(newDue),

        paymentStatus: Value(newStatus),
      ),
    );

    final updatedCredit = (widget.customer.creditBalance - amount).clamp(
      0,
      double.infinity,
    );

    await (db.update(
      db.customers,
    )..where((tbl) => tbl.id.equals(widget.customer.id))).write(
      CustomersCompanion(creditBalance: Value(updatedCredit.toDouble())),
    );
    await db
        .into(db.paymentHistories)
        .insert(
          PaymentHistoriesCompanion.insert(
            invoiceId: widget.invoice.id,

            customerId: widget.customer.id,

            amount: amount,

            paymentMethod: const Value('Cash'),

            notes: const Value(null),
          ),
        );
    if (mounted) {
      /// Customer Ledger
      ref.invalidate(customerLedgerProvider(widget.customer.phone));

      /// Payment History
      ref.invalidate(paymentHistoryProvider(widget.invoice.id));

      /// Outstanding Dashboard Card
      ref.invalidate(outstandingProvider);

      /// Dashboard KPIs
      ref.invalidate(revenueProvider);

      ref.invalidate(profitSummaryProvider);

      ref.invalidate(recentSalesProvider);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment received successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Receive Payment'),

      content: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Invoice: ${widget.invoice.invoiceNo}'),

          const SizedBox(height: 10),

          Text('Outstanding: ₹${widget.invoice.dueAmount.toStringAsFixed(2)}'),

          const SizedBox(height: 20),

          TextField(
            controller: amountController,

            keyboardType: const TextInputType.numberWithOptions(decimal: true),

            decoration: const InputDecoration(
              labelText: 'Amount Received',

              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),

          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: _receivePayment,

          child: const Text('Receive'),
        ),
      ],
    );
  }
}
