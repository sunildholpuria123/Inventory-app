import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'base_sync_mapper.dart';

class ExpenseSyncMapper
    implements BaseSyncMapper<Expense, ExpensesCompanion> {
  @override
  Map<String, dynamic> toMap(Expense expense) {
    return {
      'syncId': expense.syncId,

      'title': expense.title,

      'category': expense.category,

      'amount': expense.amount,
      'createdAt': expense.createdAt.toIso8601String(),

      'updatedAt': expense.updatedAt.toIso8601String(),

      'deletedAt': expense.deletedAt?.toIso8601String(),
    };
  }

  @override
  ExpensesCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return ExpensesCompanion(
      syncId: Value(json['syncId']),

      title: Value(json['title']),

      category: Value(json['category']),

      amount: Value(
        (json['amount'] as num).toDouble(),
      ),

      createdAt: Value(
        DateTime.parse(json['createdAt']),
      ),

      updatedAt: Value(
        DateTime.parse(json['updatedAt']),
      ),

      deletedAt: json['deletedAt'] == null
          ? const Value.absent()
          : Value(
        DateTime.parse(
          json['deletedAt'],
        ),
      ),
    );
  }
}