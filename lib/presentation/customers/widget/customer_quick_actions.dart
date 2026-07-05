import 'package:flutter/material.dart';
import 'package:inventory_desktop/presentation/customers/screen/customer_ledger_screen.dart';

import '../screen/customer_list_screen.dart';
import '../screen/due_payments_screen.dart';
import 'add_customer_dialog.dart';

class CustomerQuickActions extends StatelessWidget {
  const CustomerQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        FilledButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const AddCustomerDialog(),
            );
          },
          icon: const Icon(Icons.person_add),
          label: const Text('Add Customer'),
        ),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DuePaymentsScreen()),
            );
          },
          icon: const Icon(Icons.payments),
          label: const Text('Due Payments'),
        ),
        // OutlinedButton.icon(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (_) => const CustomerListScreen()),
        //     );
        //   },
        //   icon: const Icon(Icons.receipt_long),
        //   label: const Text('Ledger'),
        // ),
      ],
    );
  }
}
