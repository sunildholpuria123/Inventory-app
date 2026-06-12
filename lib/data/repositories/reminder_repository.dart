import 'package:drift/drift.dart'
    show ComparableExpr, BooleanExpressionOperators;

import '../database/app_database.dart';

class ReminderRepository {
  final AppDatabase db;

  ReminderRepository(this.db);

  Future<List<Invoice>> getInvoicesToRemind() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    final start = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

    final end = start.add(const Duration(days: 1));

    return (db.select(db.invoices)..where(
          (tbl) =>
              tbl.dueAmount.isBiggerThanValue(0) &
              tbl.reminderSent.equals(false) &
              tbl.dueDate.isBetweenValues(start, end),
        ))
        .get();
  }
}
