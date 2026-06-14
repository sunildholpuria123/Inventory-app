import 'package:drift/drift.dart'
    show ComparableExpr, OrderingTerm, BooleanExpressionOperators;
import 'package:rxdart/rxdart.dart' show Rx;

import '../../presentation/dashboard/model/monthly_sales.dart'
    show MonthlySales;
import '../../presentation/dashboard/model/profit_summary.dart'
    show ProfitSummary;
import '../../presentation/dashboard/model/variant_inventory.dart';
import '../database/app_database.dart';
import '../../presentation/dashboard/model/variant_sales.dart';

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

  Stream<List<Invoice>> getOverdueInvoices() {
    final today = DateTime.now();

    return (db.select(db.invoices)
          ..where(
            (tbl) =>
                tbl.dueAmount.isBiggerThanValue(0) &
                tbl.dueDate.isSmallerThanValue(today),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
        .watch();
  }

  Stream<List<Invoice>> getUpcomingDueInvoices() {
    final today = DateTime.now();

    final nextWeek = today.add(const Duration(days: 7));

    return (db.select(db.invoices)
          ..where(
            (tbl) =>
                tbl.dueAmount.isBiggerThanValue(0) &
                tbl.dueDate.isBetweenValues(today, nextWeek),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
        .watch();
  }

  Stream<List<VariantSales>> getVariantSalesAnalytics() {
    return db
        .customSelect('''
    SELECT
      ii.product_name,
      COALESCE(
        ii.variant_name,
        'Standard'
      ) AS variant_name,

      SUM(
        ii.quantity
      ) AS qty_sold,

      COALESCE(
        SUM(ii.area),
        0
      ) AS area_sold,

      SUM(
        ii.total
      ) AS revenue

    FROM invoice_items ii

    GROUP BY
      ii.product_name,
      ii.variant_name

    ORDER BY revenue DESC
    ''')
        .watch()
        .map((rows) {
          return rows.map((row) {
            return VariantSales(
              productName: row.data['product_name'].toString(),

              variantName: row.data['variant_name'].toString(),

              quantitySold: (row.data['qty_sold'] as num).toDouble(),

              areaSold: (row.data['area_sold'] as num).toDouble(),

              revenue: (row.data['revenue'] as num).toDouble(),
            );
          }).toList();
        });
  }

  Stream<List<VariantInventory>> getVariantInventoryAnalytics() {
    return db
        .customSelect('''
    SELECT

      pv.variant_name,

      p.name AS product_name,

      pv.stock_qty,

      COALESCE(
        sales.sold,
        0
      ) AS sold

    FROM product_variants pv

    INNER JOIN products p
      ON p.id = pv.product_id

    LEFT JOIN (

      SELECT

        variant_id,

        SUM(quantity) sold

      FROM invoice_items

      WHERE variant_id IS NOT NULL

      GROUP BY variant_id

    ) sales

    ON sales.variant_id = pv.id
    ''')
        .watch()
        .map((rows) {
          return rows.map((row) {
            final stock = (row.data['stock_qty'] as num).toDouble();

            final sold = (row.data['sold'] as num).toDouble();

            return VariantInventory(
              productName: row.data['product_name'].toString(),

              variantName: row.data['variant_name'].toString(),

              stock: stock,

              sold: sold,

              lowStock: stock <= 10,

              deadStock: sold == 0,

              fastMoving: sold >= 50,
            );
          }).toList();
        });
  }
}
