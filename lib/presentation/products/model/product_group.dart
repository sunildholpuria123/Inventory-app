import '../../../data/database/app_database.dart';

class ProductGroup {
  final Category category;

  final List<Product> products;

  ProductGroup({required this.category, required this.products});

  int get totalProducts  => products.length;

  double get totalStock => products.fold(0, (sum, e) => sum + e.stockQty);
}
