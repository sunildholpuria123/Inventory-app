import 'package:drift/drift.dart';

import '../database/app_database.dart';

class CategoryRepository {
  final AppDatabase db;

  CategoryRepository(this.db);

  /// GET ALL ACTIVE CATEGORIES
  Stream<List<Category>> watchCategories() {
    return (db.select(db.categories)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .watch();
  }

  /// GET CATEGORY BY ID
  Future<Category?> getCategoryById(int id) {
    return (db.select(
      db.categories,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// ADD CATEGORY
  Future<int> addCategory(CategoriesCompanion category) {
    return db.into(db.categories).insert(category);
  }

  /// UPDATE CATEGORY
  Future<bool> updateCategory(Category category) {
    return db.update(db.categories).replace(category);
  }

  /// SOFT DELETE
  Future<void> deleteCategory(int id) async {
    await (db.update(db.categories)..where((tbl) => tbl.id.equals(id))).write(
      const CategoriesCompanion(isActive: Value(false)),
    );
  }
}
