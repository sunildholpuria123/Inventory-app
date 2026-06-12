import 'package:drift/drift.dart';

import '../database/app_database.dart';

class CustomerRepository {
  final AppDatabase db;

  CustomerRepository(this.db);

  Stream<List<Customer>> watchCustomers() {
    return db.watchCustomers();
  }

  Future<void> addCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    await db.insertCustomer(
      CustomersCompanion.insert(
        name: name,
        phone: phone,

        email: Value(email?.isEmpty == true ? null : email),

        address: Value(address?.isEmpty == true ? null : address),
      ),
    );
  }

  Future<void> updateCustomerData({required Customer customer}) async {
    await db.updateCustomer(customer);
  }

  Future<void> deleteCustomer(int id) async {
    await db.deleteCustomer(id);
  }
}
