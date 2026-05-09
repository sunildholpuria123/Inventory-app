import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class SupplierRepository {
  final AppDatabase db;

  SupplierRepository(this.db);

  Stream<List<Supplier>>
  watchSuppliers() {
    return db.select(db.suppliers)
        .watch();
  }

  Future<void> addSupplier({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    await db
        .into(db.suppliers)
        .insert(
      SuppliersCompanion.insert(
        name: name,
        phone: phone,
        email: Value(email),
        address: Value(address),
      ),
    );
  }

  Future<void> updateSupplier({
    required Supplier supplier,
  }) async {
    await db
        .update(db.suppliers)
        .replace(supplier);
  }

  Future<void> deleteSupplier(
      int id,
      ) async {
    await (db.delete(db.suppliers)
      ..where(
            (tbl) =>
            tbl.id.equals(id),
      ))
        .go();
  }
}