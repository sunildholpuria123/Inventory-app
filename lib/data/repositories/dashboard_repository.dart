import 'package:drift/drift.dart' show ComparableExpr, OrderingTerm, OrderingMode;

import '../database/app_database.dart';

class DashboardRepository {
  final AppDatabase db;

  DashboardRepository(this.db);

  /// TOTAL REVENUE
  Future<double> getTotalRevenue() async {
    final result =
    await db.customSelect(
      '''
      SELECT SUM(grand_total)
      AS total
      FROM invoices
      ''',
    ).getSingle();

    return (result.data['total'] ??
        0)
        .toDouble();
  }

  /// TOTAL PRODUCTS
  Future<int> getTotalProducts() async {
    final result =
    await db.customSelect(
      '''
      SELECT COUNT(*) AS total
      FROM products
      ''',
    ).getSingle();

    return result.data['total'];
  }

  /// TOTAL CUSTOMERS
  Future<int> getTotalCustomers() async {
    final result =
    await db.customSelect(
      '''
      SELECT COUNT(*) AS total
      FROM customers
      ''',
    ).getSingle();

    return result.data['total'];
  }

  /// TOTAL INVOICES
  Future<int> getTotalSales() async {
    final result =
    await db.customSelect(
      '''
      SELECT COUNT(*) AS total
      FROM invoices
      ''',
    ).getSingle();

    return result.data['total'];
  }

  /// RECENT INVOICES
  Future<List<Invoice>>
  getRecentInvoices() async {
    return (db.select(
      db.invoices,
    )..orderBy([
          (tbl) => OrderingTerm(
        expression:
        tbl.createdAt,

        mode:
        OrderingMode.desc,
      ),
    ])
      ..limit(5))
        .get();
  }

  /// LOW STOCK PRODUCTS
  Future<List<Product>>
  getLowStockProducts() async {
    return (db.select(
      db.products,
    )..where(
          (tbl) => tbl.stockQty
          .isSmallerOrEqualValue(
        5,
      ),
    ))
        .get();
  }
}