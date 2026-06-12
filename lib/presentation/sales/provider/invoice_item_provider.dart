import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/invoice_item_repository.dart';

final invoiceItemRepositoryProvider = Provider<InvoiceItemRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return InvoiceItemRepository(db);
});
