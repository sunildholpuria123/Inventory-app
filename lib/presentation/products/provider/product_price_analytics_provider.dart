import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/products/provider/product_price_provider.dart';

final inflationReportProvider = FutureProvider((ref) {
  final repo = ref.watch(productPriceHistoryRepositoryProvider);

  return repo.getInflationReport();
});

final productPriceTrendProvider = FutureProvider.family((ref, int productId) {
  final repo = ref.watch(productPriceHistoryRepositoryProvider);

  return repo.getProductPriceTrend(productId);
});

final supplierPriceTrendProvider = FutureProvider.family((ref, int supplierId) {
  final repo = ref.watch(productPriceHistoryRepositoryProvider);

  return repo.getSupplierPriceTrend(supplierId);
});
