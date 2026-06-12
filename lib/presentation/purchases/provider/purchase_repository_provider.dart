import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/provider/dashboard_provider.dart';
import '../repository/purchase_repository.dart' show PurchaseRepository;

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return PurchaseRepository(db);
});
