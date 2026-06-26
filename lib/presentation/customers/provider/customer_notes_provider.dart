import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../../data/database/app_database.dart';
import '../repository/customer_notes_repository.dart';

final customerNotesRepositoryProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return CustomerNotesRepository(db);
});

final customerNotesProvider = StreamProvider.family<List<CustomerNote>, int>((
  ref,
  customerId,
) {
  final repo = ref.watch(customerNotesRepositoryProvider);

  return repo.watchNotes(customerId);
});
