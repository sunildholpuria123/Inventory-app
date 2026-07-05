import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../../data/database/app_database.dart';
import '../repository/customer_loyalty_repository.dart';

final customerLoyaltyRepositoryProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return CustomerLoyaltyRepository(db);
});

final customerLoyaltyProvider = StreamProvider.family<CustomerLoyalty?, int>((
  ref,
  customerId,
) {
  final repo = ref.watch(customerLoyaltyRepositoryProvider);

  return repo.watchCustomerLoyalty(customerId);
});
