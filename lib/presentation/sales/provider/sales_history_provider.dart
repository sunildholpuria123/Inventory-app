import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';

import 'sales_repository_provider.dart';

/// SEARCH
final salesSearchProvider =
StateProvider<String>(
      (ref) => '',
);

/// SALES LIST
final salesHistoryProvider =
FutureProvider<List<Invoice>>(
      (ref) async {
    final repo = ref.watch(
      salesRepositoryProvider,
    );

    final search = ref.watch(
      salesSearchProvider,
    );

    return repo.getInvoices(
      search: search,
    );
  },
);