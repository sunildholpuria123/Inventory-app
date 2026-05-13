import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_repository_provider.dart';

final totalPurchaseProvider =
FutureProvider<double>(
      (ref) async {
    final repo = ref.watch(
      purchaseRepositoryProvider,
    );

    final purchases =
    await repo.getPurchases();

    return purchases.fold<double>(
      0,
          (sum, item) =>
      (sum + item.total),
    );
  },
);