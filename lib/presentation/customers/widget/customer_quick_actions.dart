import 'package:flutter/material.dart';

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
            // Existing Add Customer dialog
          },
          icon: const Icon(Icons.person_add),
          label: const Text('Add Customer'),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // Existing Due Payments Screen
          },
          icon: const Icon(Icons.payments),
          label: const Text('Due Payments'),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // Existing Ledger Screen
          },
          icon: const Icon(Icons.receipt_long),
          label: const Text('Ledger'),
        ),
      ],
    );
  }
}
