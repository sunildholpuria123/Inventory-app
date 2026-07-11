import '../../../data/database/app_database.dart';

class PurchaseCartItem {
  final Product product;

  final ProductVariant? variant;

  final int qty;

  final double price;

  const PurchaseCartItem({
    required this.product,
    this.variant,
    required this.qty,
    required this.price,
  });

  double get total => qty * price;

  double get subtotal => qty * price;

  String get displayName {
    if (variant != null) {
      return '${product.name} (${variant!.variantName})';
    }

    return product.name;
  }

  PurchaseCartItem copyWith({
    Product? product,
    ProductVariant? variant,
    int? qty,
    double? price,
  }) {
    return PurchaseCartItem(
      product: product ?? this.product,

      variant: variant ?? this.variant,

      qty: qty ?? this.qty,

      price: price ?? this.price,
    );
  }
}
