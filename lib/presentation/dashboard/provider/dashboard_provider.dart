import 'package:drift/drift.dart' show ComparableExpr;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';

/// DATABASE
final databaseProvider =
Provider<AppDatabase>(
      (ref) {
    return AppDatabase();
  },
);

/// SIDEBAR MENU
final selectedMenuProvider =
StateProvider<int>(
      (ref) => 0,
);

/// TOTAL PRODUCTS
final totalProductsProvider =
StreamProvider<int>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return db
        .select(db.products)
        .watch()
        .map(
          (event) => event.length,
    );
  },
);

/// TOTAL CUSTOMERS
final totalCustomersProvider =
StreamProvider<int>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return db
        .select(db.customers)
        .watch()
        .map(
          (event) => event.length,
    );
  },
);

/// TOTAL SALES / ORDERS
final totalSalesProvider =
StreamProvider<int>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return db
        .select(db.invoices)
        .watch()
        .map(
          (event) => event.length,
    );
  },
);

/// TOTAL REVENUE
final revenueProvider =
FutureProvider<double>(
      (ref) async {
    final db = ref.watch(
      databaseProvider,
    );

    final result =
    await db.customSelect(
      '''
      SELECT 
      SUM(grand_total) AS total
      FROM invoices
      ''',
    ).getSingle();

    final total =
    result.data['total'];

    if (total == null) {
      return 0;
    }

    if (total is int) {
      return total.toDouble();
    }

    if (total is double) {
      return total;
    }

    return 0;
  },
);

/// LOW STOCK PRODUCTS
final lowStockProductsProvider =
StreamProvider<List<Product>>(
      (ref) {
    final db = ref.watch(
      databaseProvider,
    );

    return (db.select(
      db.products,
    )..where(
          (tbl) =>
          tbl.stockQty
              .isSmallerOrEqualValue(
            5,
          ),
    ))
        .watch();
  },
);