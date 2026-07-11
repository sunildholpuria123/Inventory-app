import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_budget_provider.dart';

class PurchaseBudgetCard extends ConsumerWidget {
  const PurchaseBudgetCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = ref.watch(purchaseBudgetProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: budget.when(
          data: (item) {
            final remaining = item.monthlyBudget - item.projectedExpense;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase Budget',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text('Budget : ₹${item.monthlyBudget.toStringAsFixed(0)}'),
                Text(
                  'Projected : ₹${item.projectedExpense.toStringAsFixed(0)}',
                ),
                Text('Remaining : ₹${remaining.toStringAsFixed(0)}'),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text(e.toString()),
        ),
      ),
    );
  }
}
