import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../../data/database/app_database.dart';
import '../repository/customer_followup_repository.dart';

final customerFollowUpRepositoryProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return CustomerFollowUpRepository(db);
});

final customerFollowUpsProvider =
    StreamProvider.family<List<CustomerFollowUp>, int>((ref, customerId) {
      final repo = ref.watch(customerFollowUpRepositoryProvider);

      return repo.watchCustomerFollowUps(customerId);
    });
