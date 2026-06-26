import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class CustomerDocumentsRepository {
  final AppDatabase db;

  CustomerDocumentsRepository(this.db);

  Stream<List<CustomerDocument>> watchDocuments(int customerId) {
    return (db.select(db.customerDocuments)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<void> addDocument({
    required int customerId,
    required String name,
    required String filePath,
  }) async {
    await db
        .into(db.customerDocuments)
        .insert(
          CustomerDocumentsCompanion.insert(
            customerId: customerId,
            name: name,
            filePath: filePath,
          ),
        );
  }

  Future<void> deleteDocument(int id) async {
    await (db.delete(db.customerDocuments)..where((t) => t.id.equals(id))).go();
  }
}
