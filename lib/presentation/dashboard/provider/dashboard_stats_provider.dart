import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart' show Invoice, Product;
import '../../../data/repositories/dashboard_repository.dart';

import 'dashboard_provider.dart';

final dashboardRepositoryProvider =
Provider<DashboardRepository>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return DashboardRepository(
      db,
    );
  },
);

/// REVENUE
final revenueProvider =
StreamProvider<double>((ref) {
  final repo =
  ref.watch(dashboardRepositoryProvider);

    return repo.getTotalRevenue();
  },
);

/// PRODUCTS
final totalProductsProvider =
StreamProvider<int>((ref) {
  final repo =
  ref.watch(dashboardRepositoryProvider);

    return repo.getTotalProducts();
  },
);

/// CUSTOMERS
final totalCustomersProvider =
StreamProvider<int>((ref) {
  final repo =
  ref.watch(dashboardRepositoryProvider);

    return repo.getTotalCustomers();
  },
);

/// SALES
final totalSalesProvider =
StreamProvider<int>((ref) {
  final repo =
  ref.watch(dashboardRepositoryProvider);

    return repo.getTotalSales();
  },
);

/// LOW STOCK

final lowStockProvider =
StreamProvider<List<Product>>((ref) {
  final repo =
  ref.watch(
    dashboardRepositoryProvider,
  );

  return repo.getLowStockProducts();
});

/// RECENT SALES
final recentSalesProvider =
StreamProvider<List<Invoice>>((ref) {
  final repo =
  ref.watch(
    dashboardRepositoryProvider,
  );

  return repo.getRecentInvoices();
});