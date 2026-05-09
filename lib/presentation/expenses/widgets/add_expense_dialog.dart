import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/expense_provider.dart';

class AddExpenseDialog
    extends ConsumerStatefulWidget {
  const AddExpenseDialog({
    super.key,
  });

  @override
  ConsumerState<AddExpenseDialog>
  createState() =>
      _AddExpenseDialogState();
}

class _AddExpenseDialogState
    extends ConsumerState<
        AddExpenseDialog> {
  final titleController =
  TextEditingController();

  final amountController =
  TextEditingController();

  final noteController =
  TextEditingController();

  String category = 'Transport';

  final categories = [
    'Transport',
    'Office',
    'Food',
    'Maintenance',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Expense',
      ),

      content: SizedBox(
        width: 400,

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            TextField(
              controller:
              titleController,

              decoration:
              const InputDecoration(
                labelText:
                'Expense Title',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              amountController,

              keyboardType:
              TextInputType.number,

              decoration:
              const InputDecoration(
                labelText:
                'Amount',
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField(
              value: category,

              items:
              categories.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),

              onChanged: (value) {
                category = value!;
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              noteController,

              decoration:
              const InputDecoration(
                labelText: 'Note',
              ),
            ),
          ],
        ),
      ),

      actions: [
        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(
              expenseRepositoryProvider,
            );

            await repo.addExpense(
              title:
              titleController.text,
              amount: double.parse(
                amountController.text,
              ),
              category: category,
              note:
              noteController.text,
            );

            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Save',
          ),
        ),
      ],
    );
  }
}