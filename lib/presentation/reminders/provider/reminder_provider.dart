import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart' show databaseProvider;
import '../../../data/repositories/reminder_repository.dart'
    show ReminderRepository;

final reminderRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);

  return ReminderRepository(db);
});
