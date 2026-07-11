import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'purchase_repository_provider.dart';

final totalPurchaseProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(purchaseRepositoryProvider);

  return repo.watchTotalPurchases();
});

final purchasesBySupplierProvider = StreamProvider<Map<String, double>>((ref) {
  final repo = ref.watch(purchaseRepositoryProvider);

  return repo.watchPurchasesBySupplier();
});
