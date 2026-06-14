import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../purchases/provider/purchase_provider.dart';

final purchaseReturnsProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(purchaseRepositoryProvider);

  return repo.watchTotalPurchaseReturns();
});

final pendingRefundsProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(purchaseRepositoryProvider);

  return repo.watchPendingRefunds();
});
