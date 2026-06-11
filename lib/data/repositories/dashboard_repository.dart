import 'package:drift/drift.dart' show ComparableExpr, OrderingTerm, OrderingMode;

import '../../presentation/dashboard/model/monthly_sales.dart' show MonthlySales;
import '../../presentation/dashboard/model/profit_summary.dart' show ProfitSummary;
import '../database/app_database.dart';

class DashboardRepository {
  final AppDatabase db;

  DashboardRepository(this.db);

  /// TOTAL REVENUE
  Stream<double> getTotalRevenue() {
    return db.customSelect(
        '''
    SELECT COALESCE(SUM(grand_total),0) AS total
    FROM invoices
    '''
    ).watch().map(
          (rows) => (rows.first.data['total'] ?? 0).toDouble(),
    );
  }

  /// TOTAL PRODUCTS
  Stream<int> getTotalProducts()  {
    return db.select(db.products)
        .watch()
        .map((items) => items.length);
  }

  /// TOTAL CUSTOMERS
  Stream<int> getTotalCustomers()  {
    return db.select(db.customers)
        .watch()
        .map((items) => items.length);
  }

  /// TOTAL INVOICES
  Stream<int> getTotalSales()  {
    return db.select(db.invoices)
        .watch()
        .map((items) => items.length);
  }

  /// RECENT INVOICES
  Stream<List<Invoice>>
  getRecentInvoices() {
    return (db.select(db.invoices)
      ..orderBy([
            (tbl) => OrderingTerm.desc(
          tbl.createdAt,
        )
      ])
      ..limit(5))
        .watch();
  }

  /// LOW STOCK PRODUCTS
 Stream<List<Product>>
getLowStockProducts() {
  return (db.select(db.products)
    ..where(
          (tbl) =>
          tbl.stockQty.isSmallerOrEqualValue(5),
    ))
      .watch();
}

  Stream<List<MonthlySales>>
  getMonthlySalesAnalytics() {

    return db.customSelect(
        '''
    SELECT
      strftime('%m', created_at) AS month,
      SUM(grand_total) AS total
    FROM invoices
    GROUP BY month
    ORDER BY month
    '''
    ).watch().map((rows) {

      const monthNames = [
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

      return rows.map((row) {

        final month =
        int.parse(
          row.data['month']
              .toString(),
        );

        return MonthlySales(
          month:
          monthNames[month],

          amount:
          (row.data['total']
          as num)
              .toDouble(),
        );
      }).toList();
    });
  }

  Stream<ProfitSummary> getProfitSummary() {
    return Stream.combineLatest3(
      db.customSelect(
          '''
      SELECT COALESCE(SUM(grand_total), 0) AS total
      FROM invoices
      '''
      ).watch(),

      db.customSelect(
          '''
      SELECT COALESCE(SUM(total_amount), 0) AS total
      FROM purchases
      '''
      ).watch(),

      db.customSelect(
          '''
      SELECT COALESCE(SUM(amount), 0) AS total
      FROM expenses
      '''
      ).watch(),

          (
          salesRows,
          purchaseRows,
          expenseRows,
          ) {
        final revenue =
            (salesRows.first.data['total']
            as num?)
                ?.toDouble() ??
                0;

        final purchases =
            (purchaseRows.first.data['total']
            as num?)
                ?.toDouble() ??
                0;

        final expenses =
            (expenseRows.first.data['total']
            as num?)
                ?.toDouble() ??
                0;

        final profit =
            revenue -
                purchases -
                expenses;

        return ProfitSummary(
          revenue: revenue,
          purchases: purchases,
          expenses: expenses,
          profit: profit,
        );
      },
    );
  }
}