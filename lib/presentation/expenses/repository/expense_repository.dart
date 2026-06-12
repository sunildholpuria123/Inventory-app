import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart'
    show Expense, AppDatabase, ExpensesCompanion;

class ExpenseRepository {
  final AppDatabase db;

  ExpenseRepository(this.db);

  Stream<List<Expense>> watchExpenses() {
    return db.select(db.expenses).watch();
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    String? note,
  }) async {
    await db.insertExpense(
      ExpensesCompanion.insert(
        title: title,
        amount: amount,
        category: category,
        note: Value(note),
      ),
    );
  }

  Future<void> deleteExpense(int id) async {
    await (db.delete(db.expenses)..where((tbl) => tbl.id.equals(id))).go();
  }
}
