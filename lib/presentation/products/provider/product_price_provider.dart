import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../repository/product_price_history_repository.dart';

final productPriceHistoryRepositoryProvider = Provider((ref) {
  return ProductPriceHistoryRepository(ref.watch(databaseProvider));
});

final productPriceHistoryProvider =
    FutureProvider.family<List<ProductPriceHistory>, int>((ref, productId) {
      final repo = ref.watch(productPriceHistoryRepositoryProvider);

      return repo.getPriceHistory(productId);
    });

final inflationHistoryProvider = FutureProvider<List<ProductPriceHistory>>((
  ref,
) {
  final repo = ref.watch(productPriceHistoryRepositoryProvider);

  return repo.getLatestInflations();
});
