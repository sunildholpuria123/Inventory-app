import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/database_provider.dart';
import '../../products/provider/product_provider.dart';
import 'sales_history_provider.dart';

class ProfitAnalytics {
  final double revenue;
  final double estimatedProfit;

  const ProfitAnalytics({
    required this.revenue,
    required this.estimatedProfit,
  });
}

final profitAnalyticsProvider =
FutureProvider<ProfitAnalytics>(
      (ref) async {
    final invoices =
    await ref.watch(
      salesHistoryProvider.future,
    );

    final products =
    await ref.watch(
      productsProvider.future,
    );

    final productMap = {
      for (final p in products)
        p.id: p,
    };

    double revenue = 0;
    double cost = 0;

    for (final invoice
    in invoices) {
      revenue +=
          invoice.grandTotal;
    }

    final db = ref.read(
      appDatabaseProvider,
    );

    final items =
    await db.select(
      db.invoiceItems,
    ).get();

    for (final item
    in items) {
      final product =
      productMap[
      item.productId];

      if (product !=
          null) {
        cost +=
            product
                .purchasePrice *
                item.quantity;
      }
    }

    return ProfitAnalytics(
      revenue: revenue,
      estimatedProfit:
      revenue - cost,
    );
  },
);