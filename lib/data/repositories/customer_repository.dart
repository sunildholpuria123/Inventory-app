import '../database/app_database.dart';

class CustomerRepository {
  final AppDatabase db;

  CustomerRepository(this.db);

  Future<List<Customer>> getCustomers() {
    return db.getAllCustomers();
  }

  Future<void> addCustomer({
    required String name,
    required String phone,
  }) async {
    await db.insertCustomer(
      CustomersCompanion.insert(
        name: name,
        phone: phone,
      ),
    );
  }
}