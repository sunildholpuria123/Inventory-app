import 'package:drift/drift.dart' show ComparableExpr, OrderingTerm, OrderingMode;

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
}