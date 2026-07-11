import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart' show Supplier;
import '../../../data/providers/database_provider.dart';
import '../models/purchase_item.dart';
import '../repository/purchase_repository.dart';

final purchaseItemsProvider = StateProvider<List<PurchaseCartItem>>((ref) => []);

final selectedSupplierProvider = StateProvider<Supplier?>((ref) => null);

final purchaseSubtotalProvider = Provider<double>((ref) {
  final items = ref.watch(purchaseItemsProvider);

  return items.fold(0, (sum, item) => sum + item.subtotal);
});

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return PurchaseRepository(db);
});
