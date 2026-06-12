import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/sales_repository.dart';

final salesRepositoryProvider = Provider<SalesRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return SalesRepository(db);
});
