import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class SupplierRepository {
  final AppDatabase db;

  SupplierRepository(this.db);

  Stream<List<Supplier>> watchSuppliers() {
    return (db.select(db.suppliers)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .watch();
  }

  Future<void> addSupplier({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? gstNumber,
    double creditBalance = 0,
  }) async {
    await db
        .into(db.suppliers)
        .insert(
          SuppliersCompanion.insert(
            name: name,

            phone: phone,

            email: Value(email),

            address: Value(address),

            gstNumber: Value(gstNumber),

            creditBalance: Value(creditBalance),
          ),
        );
  }

  Future<void> updateSupplier({required Supplier supplier}) async {
    await db.update(db.suppliers).replace(supplier);
  }

  Future<void> updateCreditBalance({
    required int supplierId,
    required double amount,
  }) async {
    final supplier = await (db.select(
      db.suppliers,
    )..where((tbl) => tbl.id.equals(supplierId))).getSingle();

    await (db.update(
      db.suppliers,
    )..where((tbl) => tbl.id.equals(supplierId))).write(
      SuppliersCompanion(creditBalance: Value(supplier.creditBalance + amount)),
    );
  }

  Future<void> deleteSupplier(int id) async {
    await (db.update(db.suppliers)..where((tbl) => tbl.id.equals(id))).write(
      const SuppliersCompanion(isActive: Value(false)),
    );
  }

  Stream<List<Purchase>> watchSupplierPurchases(String supplierName) {
    return (db.select(db.purchases)
          ..where((tbl) => tbl.supplierName.equals(supplierName))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<void> makeSupplierPayment({
    required int supplierId,
    required double amount,
    required String paymentMethod,
    int? purchaseId,
    String? notes,
  }) async {
    final supplier = await (db.select(
      db.suppliers,
    )..where((tbl) => tbl.id.equals(supplierId))).getSingle();

    final updatedBalance = (supplier.creditBalance - amount).clamp(
      0,
      double.infinity,
    );

    await (db.update(
      db.suppliers,
    )..where((tbl) => tbl.id.equals(supplierId))).write(
      SuppliersCompanion(creditBalance: Value(updatedBalance.toDouble())),
    );

    await db
        .into(db.supplierPaymentHistories)
        .insert(
          SupplierPaymentHistoriesCompanion.insert(
            supplierId: supplierId,

            purchaseId: Value(purchaseId),

            amount: amount,

            paymentMethod: Value(paymentMethod),

            notes: Value(notes),
          ),
        );
  }

  Stream<List<SupplierPaymentHistory>> watchSupplierPayments(int supplierId) {
    return (db.select(db.supplierPaymentHistories)
          ..where((tbl) => tbl.supplierId.equals(supplierId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Stream<double> watchTotalPayables() {
    return db
        .customSelect('''
    SELECT COALESCE(
      SUM(
        credit_balance
      ),
      0
    ) total
    FROM suppliers
    ''')
        .watch()
        .map((rows) {
          return (rows.first.data['total'] as num?)?.toDouble() ?? 0;
        });
  }
}
