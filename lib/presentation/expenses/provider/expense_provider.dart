import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../repository/expense_repository.dart';

final expenseRepositoryProvider =
Provider<ExpenseRepository>((ref) {
  final db = ref.watch(
    databaseProvider,
  );

  return ExpenseRepository(db);
});

final expensesProvider =
StreamProvider<List<Expense>>(
      (ref) {
    final repo = ref.watch(
      expenseRepositoryProvider,
    );

    return repo.watchExpenses();
  },
);

final expenseSearchProvider =
StateProvider<String>(
      (ref) => '',
);