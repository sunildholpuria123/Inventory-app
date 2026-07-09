import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';

class CustomerSyncMapper {
  static Map<String, dynamic> toMap(Customer customer) {
    return {
      'id': customer.id,
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'address': customer.address,
      'creditBalance': customer.creditBalance,
      'createdAt': customer.createdAt.toIso8601String(),
      'updatedAt': customer.updatedAt?.toIso8601String(),

    };
  }

  static CustomersCompanion toCompanion(
      Map<String, dynamic> json,
      ) {
    return CustomersCompanion.insert(
      name: json['name'],
      phone: json['phone'],
      email: Value(json['email']),
      address: Value(json['address']),
      creditBalance: Value(
        (json['creditBalance'] as num).toDouble(),
      ),
    );
  }
}