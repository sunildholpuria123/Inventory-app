import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';


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