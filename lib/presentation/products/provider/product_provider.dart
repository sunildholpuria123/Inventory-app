import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/product_repository.dart';
import '../../categories/provider/category_provider.dart';
import '../model/product_group.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return ProductRepository(db);
});

final productsProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productRepositoryProvider);

  final search = ref.watch(productSearchProvider);

  final categoryId = ref.watch(productCategoryFilterProvider);

  return repo.watchProducts(search: search, categoryId: categoryId);
});

final productSearchProvider = StateProvider<String>((ref) => '');

final productCategoryFilterProvider = StateProvider<int?>((ref) => null);
final expandedCategoriesProvider = StateProvider<Set<int>>((ref) => {});

final groupedProductsProvider = Provider<AsyncValue<List<ProductGroup>>>((ref) {
  final productsAsync = ref.watch(productsProvider);

  final categoriesAsync = ref.watch(categoriesProvider);

  return productsAsync.whenData((products) {
    final categories = categoriesAsync.value ?? [];

    final groups = categories
        .map((category) {
          final categoryProducts = products.where((product) {
            return product.categoryId == category.id;
          }).toList();

          return ProductGroup(category: category, products: categoryProducts);
        })
        .where((group) => group.products.isNotEmpty)
        .toList();

    return groups;
  });
});
