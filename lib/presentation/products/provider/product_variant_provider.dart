import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/product_variant_repository.dart';

final productVariantRepositoryProvider = Provider<ProductVariantRepository>((
  ref,
) {
  final db = ref.watch(databaseProvider);

  return ProductVariantRepository(db);
});

final variantsProvider = StreamProvider.family<List<ProductVariant>, int>((
  ref,
  productId,
) {
  final repo = ref.watch(productVariantRepositoryProvider);

  return repo.watchVariants(productId);
});
