import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class CustomerNotesRepository {
  final AppDatabase db;

  CustomerNotesRepository(this.db);

  Stream<List<CustomerNote>> watchNotes(int customerId) {
    return (db.select(db.customerNotes)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<void> addNote({required int customerId, required String note}) async {
    await db
        .into(db.customerNotes)
        .insert(
          CustomerNotesCompanion.insert(customerId: customerId, note: note),
        );
  }

  Future<void> deleteNote(int id) async {
    await (db.delete(db.customerNotes)..where((t) => t.id.equals(id))).go();
  }
}
