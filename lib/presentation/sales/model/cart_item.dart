import '../../../data/database/app_database.dart';

class CartItem {
  final Product product;

  final ProductVariant? variant;

  final int quantity;

  final double unitPrice;

  /// Used for Marble/Granite/Tiles
  final double? height;

  final double? width;

  CartItem({
    required this.product,
    this.variant,
    required this.quantity,
    required this.unitPrice,
    this.height,
    this.width,
  });

  bool get isAreaBased => height != null && width != null;

  double get area {
    if (!isAreaBased) {
      return 0;
    }

    return height! * width!;
  }

  double get total {
    if (isAreaBased) {
      final rate = variant?.sellingPrice ?? unitPrice;

      return area * rate * quantity;
    }

    return quantity * unitPrice;
  }

  String get displayName {
    if (variant != null) {
      return '${product.name}'
          ' - '
          '${variant!.variantName}';
    }

    return product.name;
  }

  CartItem copyWith({
    Product? product,
    ProductVariant? variant,
    int? quantity,
    double? unitPrice,
    double? height,
    double? width,
  }) {
    return CartItem(
      product: product ?? this.product,

      variant: variant ?? this.variant,

      quantity: quantity ?? this.quantity,

      unitPrice: unitPrice ?? this.unitPrice,

      height: height ?? this.height,

      width: width ?? this.width,
    );
  }
}
