import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/customer_repository.dart';

final customerRepositoryProvider =
Provider<CustomerRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return CustomerRepository(db);
});

final customerSearchProvider =
StateProvider<String>((ref) => '');

final customersProvider =
StreamProvider<List<Customer>>((ref) {
  final repo = ref.watch(
    customerRepositoryProvider,
  );

  return repo.watchCustomers();
});