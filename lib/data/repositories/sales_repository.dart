import '../database/app_database.dart';

class SalesRepository {
  final AppDatabase db;

  SalesRepository(this.db);

  Future<void> createSale({
    required int customerId,
    required double total,
  }) async {
    await db.createSale(
      SalesCompanion.insert(
        customerId: customerId,
        invoiceNo: 'INV-${DateTime.now().millisecondsSinceEpoch}',
        total: total,
        discount: 0,
        tax: 0,
        grandTotal: total,
        paymentStatus: 'PAID',
      ),
    );
  }
}