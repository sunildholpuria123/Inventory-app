import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/category_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final db = ref.watch(databaseProvider);

  return CategoryRepository(db);
});

final categoriesProvider = StreamProvider<List<Category>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);

  return repo.watchCategories();
});

final categorySearchProvider = StateProvider<String>((ref) => '');

final filteredCategoriesProvider = Provider<AsyncValue<List<Category>>>((ref) {
  final categories = ref.watch(categoriesProvider);

  final search = ref.watch(categorySearchProvider);

  return categories.whenData((items) {
    if (search.isEmpty) {
      return items;
    }

    return items.where((e) {
      return e.name.toLowerCase().contains(search.toLowerCase());
    }).toList();
  });
});
