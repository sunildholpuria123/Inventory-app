import 'package:flutter/material.dart';
import '../../../core/utils/whatsapp_helper.dart';
import '../../customers/screen/customer_ledger_screen.dart';
import '../model/receivable_data.dart';

class ReceivableTile extends StatelessWidget {
  final ReceivableData item;

  const ReceivableTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final customer = item.customer;

    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(customer.name),
        subtitle: Text('Due ₹${item.amount.toStringAsFixed(0)}'),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              icon: const Icon(Icons.chat, color: Colors.green),
              onPressed: () async {
                await WhatsAppHelper.sendPaymentReminder(
                  phone: customer.phone,
                  customerName: customer.name,
                  amount: item.amount,
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.receipt_long),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CustomerLedgerScreen(
                          customer: customer,
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
