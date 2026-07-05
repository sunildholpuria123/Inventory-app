import 'package:flutter/material.dart';

import '../screens/cash_flow_screen.dart';
import '../screens/payables_screen.dart';
import '../screens/profit_loss_screen.dart';
import '../screens/receivables_screen.dart';
import '../screens/transaction_timeline_screen.dart';

class FinanceQuickActions extends StatelessWidget {
  const FinanceQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CashFlowScreen()),
            );
          },
          icon: const Icon(Icons.account_balance_wallet),
          label: const Text('Cash Flow'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReceivablesScreen()),
            );
          },
          icon: const Icon(Icons.payments),
          label: const Text('Receivables'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PayablesScreen()),
            );
          },
          icon: const Icon(Icons.account_balance),
          label: const Text('Payables'),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.money_off),
          label: const Text('Add Expense'),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.payments),
          label: const Text('Supplier Payment'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfitLossScreen()),
            );
          },
          icon: const Icon(Icons.analytics),
          label: const Text('Profit & Loss'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TransactionTimelineScreen(),
              ),
            );
          },
          icon: const Icon(Icons.timeline),
          label: const Text('Timeline'),
        ),
      ],
    );
  }
}
