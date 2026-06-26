import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class CustomerFollowUpRepository {
  final AppDatabase db;

  CustomerFollowUpRepository(this.db);

  Stream<List<CustomerFollowUp>> watchCustomerFollowUps(int customerId) {
    return (db.select(db.customerFollowUps)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm(expression: t.followUpDate)]))
        .watch();
  }

  Future<void> addFollowUp({
    required int customerId,
    required String title,
    String? description,
    required DateTime date,
  }) async {
    await db
        .into(db.customerFollowUps)
        .insert(
          CustomerFollowUpsCompanion.insert(
            customerId: customerId,
            title: title,
            description: Value(description),
            followUpDate: date,
          ),
        );
  }

  Future<void> updateCompleted({
    required int id,
    required bool completed,
  }) async {
    await (db.update(db.customerFollowUps)..where((t) => t.id.equals(id)))
        .write(CustomerFollowUpsCompanion(completed: Value(completed)));
  }

  Future<void> delete(int id) async {
    await (db.delete(db.customerFollowUps)..where((t) => t.id.equals(id))).go();
  }
}
