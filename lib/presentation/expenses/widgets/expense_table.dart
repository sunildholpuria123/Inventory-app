import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/expense_provider.dart';

class ExpenseTable extends ConsumerWidget {
  final List<Expense> expenses;

  const ExpenseTable({super.key, required this.expenses});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Actions')),
          ],

          rows: expenses.map((e) {
            return DataRow(
              cells: [
                DataCell(Text(e.title)),

                DataCell(Chip(label: Text(e.category))),

                DataCell(
                  Text(
                    '₹${e.amount}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataCell(Text(e.createdAt.toString())),

                DataCell(
                  IconButton(
                    onPressed: () async {
                      final repo = ref.read(expenseRepositoryProvider);

                      await repo.deleteExpense(e.id);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
