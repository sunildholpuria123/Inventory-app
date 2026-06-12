import '../../../data/database/app_database.dart';

class PurchaseItem {
  final Product product;

  final int qty;

  final double price;

  const PurchaseItem({
    required this.product,
    required this.qty,
    required this.price,
  });

  /// TOTAL
  double get total => qty * price;

  double get subtotal => qty * price;

  PurchaseItem copyWith({Product? product, int? qty, double? price}) {
    return PurchaseItem(
      product: product ?? this.product,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }
}
