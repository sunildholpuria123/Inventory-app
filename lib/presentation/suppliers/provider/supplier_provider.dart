import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../repository/supplier_repository.dart';

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return SupplierRepository(db);
});

final suppliersProvider = StreamProvider<List<Supplier>>((ref) {
  final repo = ref.watch(supplierRepositoryProvider);

  return repo.watchSuppliers();
});

final supplierSearchProvider = StateProvider<String>((ref) => '');

