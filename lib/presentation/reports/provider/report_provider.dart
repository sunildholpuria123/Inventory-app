import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/reports_repository.dart';

import '../../dashboard/provider/dashboard_provider.dart';

final reportsRepositoryProvider =
Provider<ReportsRepository>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return ReportsRepository(
      db,
    );
  },
);

/// MONTHLY SALES
final monthlySalesProvider =
FutureProvider((ref) async {
  final repo = ref.watch(
    reportsRepositoryProvider,
  );

  return repo.getMonthlySales();
});

/// TOP PRODUCTS
final topProductsProvider =
FutureProvider((ref) async {
  final repo = ref.watch(
    reportsRepositoryProvider,
  );

  return repo.getTopProducts();
});

/// PROFIT
final profitProvider =
FutureProvider<double>(
      (ref) async {
    final repo = ref.watch(
      reportsRepositoryProvider,
    );

    return repo.getProfit();
  },
);

/// INVENTORY VALUE
final inventoryValueProvider =
FutureProvider<double>(
      (ref) async {
    final repo = ref.watch(
      reportsRepositoryProvider,
    );

    return repo
        .getInventoryValue();
  },
);