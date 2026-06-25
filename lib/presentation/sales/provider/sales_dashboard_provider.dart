import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_repository_provider.dart';

class SalesDashboardData {
  final double totalSales;
  final double totalDue;
  final int totalInvoices;

  const SalesDashboardData({
    required this.totalSales,
    required this.totalDue,
    required this.totalInvoices,
  });
}

final salesDashboardProvider = FutureProvider<SalesDashboardData>((ref) async {
  final repo = ref.read(salesRepositoryProvider);

  final invoices = await repo.getAllInvoices();

  double totalSales = 0;
  double totalDue = 0;

  for (final e in invoices) {
    totalSales += e.grandTotal;
    totalDue += e.dueAmount;
  }

  return SalesDashboardData(
    totalSales: totalSales,
    totalDue: totalDue,
    totalInvoices: invoices.length,
  );
});
