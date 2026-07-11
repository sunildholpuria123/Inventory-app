import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'top_selling_products_provider.dart';

class ProductPerformance {
  final int totalProductsSold;
  final double totalRevenue;

  const ProductPerformance({
    required this.totalProductsSold,
    required this.totalRevenue,
  });
}

final productPerformanceProvider =
FutureProvider<ProductPerformance>(
      (ref) async {
    final products =
    await ref.watch(
      topSellingProductsProvider
          .future,
    );

    int sold = 0;
    double revenue = 0;

    for (final p in products) {
      sold += p.quantity;
      revenue += p.amount;
    }

    return ProductPerformance(
      totalProductsSold:
      sold,
      totalRevenue:
      revenue,
    );
  },
);