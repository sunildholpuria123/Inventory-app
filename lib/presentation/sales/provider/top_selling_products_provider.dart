import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../../data/database/app_database.dart';

class TopSellingProduct {
  final String name;
  final int quantity;
  final double amount;

  const TopSellingProduct({
    required this.name,
    required this.quantity,
    required this.amount,
  });
}

final topSellingProductsProvider =
FutureProvider<List<TopSellingProduct>>(
      (ref) async {
    final db = ref.read(
      appDatabaseProvider,
    );

    final items =
    await db.select(
      db.invoiceItems,
    ).get();

    final map =
    <String, TopSellingProduct>{};

    for (final e in items) {
      final current =
      map[e.productName];

      if (current == null) {
        map[e.productName] =
            TopSellingProduct(
              name: e.productName,
              quantity:
              e.quantity,
              amount:
              e.total,
            );
      } else {
        map[e.productName] =
            TopSellingProduct(
              name: e.productName,
              quantity:
              current.quantity +
                  e.quantity,
              amount:
              current.amount +
                  e.total,
            );
      }
    }

    final result =
    map.values.toList()
      ..sort(
            (a, b) =>
            b.quantity
                .compareTo(
              a.quantity,
            ),
      );

    return result.take(10).toList();
  },
);