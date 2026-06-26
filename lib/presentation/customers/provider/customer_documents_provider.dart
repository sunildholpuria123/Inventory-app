import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../../data/database/app_database.dart';
import '../repository/customer_documents_repository.dart';

final customerDocumentsRepositoryProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return CustomerDocumentsRepository(db);
});

final customerDocumentsProvider =
    StreamProvider.family<List<CustomerDocument>, int>((ref, customerId) {
      final repo = ref.watch(customerDocumentsRepositoryProvider);

      return repo.watchDocuments(customerId);
    });
