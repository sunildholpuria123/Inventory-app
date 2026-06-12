import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import 'sales_repository_provider.dart';

final salesSearchProvider = StateProvider<String>((ref) => '');

final salesHistoryProvider = StreamProvider<List<Invoice>>((ref) {
  final repo = ref.watch(salesRepositoryProvider);

  final search = ref.watch(salesSearchProvider);

  return repo.watchInvoices(search: search);
});
