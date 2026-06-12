import 'package:drift/drift.dart' show ComparableExpr, OrderingTerm;
import 'package:rxdart/rxdart.dart' show Rx;

import '../../presentation/dashboard/model/monthly_sales.dart'
    show MonthlySales;
import '../../presentation/dashboard/model/profit_summary.dart'
    show ProfitSummary;
import '../database/app_database.dart';

class DashboardRepository {
  final AppDatabase db;

  DashboardRepository(this.db);

  /// TOTAL REVENUE
  Stream<double> getTotalRevenue() {
    return db
        .customSelect('''
    SELECT COALESCE(SUM(grand_total),0) AS total
    FROM invoices
    ''')
        .watch()
        .map((rows) => (rows.first.data['total'] ?? 0).toDouble());
  }

  /// TOTAL PRODUCTS
  Stream<int> getTotalProducts() {
    return db.select(db.products).watch().map((items) => items.length);
  }

  /// TOTAL CUSTOMERS
  Stream<int> getTotalCustomers() {
    return db.select(db.customers).watch().map((items) => items.length);
  }

  /// TOTAL INVOICES
  Stream<int> getTotalSales() {
    return db.select(db.invoices).watch().map((items) => items.length);
  }

  /// RECENT INVOICES
  Stream<List<Invoice>> getRecentInvoices() {
    return (db.select(db.invoices)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
          ..limit(5))
        .watch();
  }

  /// LOW STOCK PRODUCTS
  Stream<List<Product>> getLowStockProducts() {
    return (db.select(
      db.products,
    )..where((tbl) => tbl.stockQty.isSmallerOrEqualValue(5))).watch();
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month];
  }

  Stream<List<MonthlySales>> getMonthlySalesAnalytics() {
    return db.select(db.invoices).watch().map((invoices) {
      final Map<String, double> monthlyTotals = {};

      for (final invoice in invoices) {
        final month = _monthName(invoice.createdAt.month);

        monthlyTotals[month] = (monthlyTotals[month] ?? 0) + invoice.grandTotal;
      }

      return monthlyTotals.entries
          .map((entry) => MonthlySales(month: entry.key, amount: entry.value))
          .toList();
    });
  }

  Stream<ProfitSummary> getProfitSummary() {
    return Rx.combineLatest3(
      /// Revenue
      db.customSelect('''
      SELECT COALESCE(
        SUM(grand_total),
        0
      ) AS total
      FROM invoices
      ''').watch(),

      /// Purchases
      db.customSelect('''
      SELECT COALESCE(
        SUM(total),
        0
      ) AS total
      FROM purchases
      ''').watch(),

      /// Expenses
      db.customSelect('''
      SELECT COALESCE(
        SUM(amount),
        0
      ) AS total
      FROM expenses
      ''').watch(),

      (salesRows, purchaseRows, expenseRows) {
        final revenue =
            (salesRows.first.data['total'] as num?)?.toDouble() ?? 0;

        final purchases =
            (purchaseRows.first.data['total'] as num?)?.toDouble() ?? 0;

        final expenses =
            (expenseRows.first.data['total'] as num?)?.toDouble() ?? 0;

        return ProfitSummary(
          revenue: revenue,

          purchases: purchases,

          expenses: expenses,

          profit: revenue - purchases - expenses,
        );
      },
    );
  }
}
