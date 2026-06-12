import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/expense_provider.dart';
import '../widgets/add_expense_dialog.dart';
import '../widgets/expense_analytics.dart';
import '../widgets/expense_table.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Expenses',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AddExpenseDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Expense'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const ExpenseAnalytics(),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Expense',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(expenseSearchProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: expenses.when(
                data: (items) {
                  final search = ref.watch(expenseSearchProvider);

                  final filtered = items.where((e) {
                    return e.title.toLowerCase().contains(search.toLowerCase());
                  }).toList();

                  return ExpenseTable(expenses: filtered);
                },

                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text(e.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
