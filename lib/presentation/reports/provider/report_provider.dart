import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/model/inventory_analytics_model.dart';
import '../../../data/database/model/payment_collection_model.dart';
import '../../../data/repositories/reports_repository.dart';
import '../../dashboard/provider/dashboard_provider.dart';

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReportsRepository(db);
});

/// =======================
/// MONTHLY SALES
/// =======================

final monthlySalesProvider = FutureProvider((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getMonthlySales();
});

/// =======================
/// TOP PRODUCTS
/// =======================

final topProductsProvider = FutureProvider((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getTopProducts();
});

/// =======================
/// TOP CUSTOMERS
/// =======================

final topCustomersReportProvider = FutureProvider((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getTopCustomers();
});

/// =======================
/// PROFIT
/// =======================

final profitProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getProfit();
});

/// =======================
/// INVENTORY VALUE
/// =======================

final inventoryValueProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getInventoryValue();
});

/// =======================
/// EXPENSE ANALYTICS
/// =======================

final expenseAnalyticsProvider =
FutureProvider<Map<String, double>>((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getExpenseAnalytics();
});

/// =======================
/// INVENTORY ANALYTICS
/// =======================

final inventoryAnalyticsProvider =
FutureProvider<InventoryAnalytics>((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getInventoryAnalytics();
});

/// =======================
/// PAYMENT COLLECTION
/// =======================

final paymentCollectionProvider =
FutureProvider<PaymentCollectionModel>((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getPaymentCollection();
});

/// =======================
/// REVENUE TREND
/// =======================

final revenueTrendProvider = FutureProvider((ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getProfitTrend();
});