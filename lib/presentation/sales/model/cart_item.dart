class CartItem {
  final dynamic product;

  final int qty;

  final double price;

  CartItem({
    required this.product,
    required this.qty,
    required this.price,
  });

  /// TOTAL
  double get total =>
      qty * price;

  /// PRODUCT NAME
  String get productName =>
      product.name;
}