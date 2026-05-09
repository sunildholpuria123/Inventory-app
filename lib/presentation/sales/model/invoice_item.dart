import '../../../data/database/app_database.dart';

class InvoiceItem {
  final Product product;

  final int qty;

  final double price;

  const InvoiceItem({
    required this.product,
    required this.qty,
    required this.price,
  });

  double get subtotal => qty * price;

  InvoiceItem copyWith({
    Product? product,
    int? qty,
    double? price,
  }) {
    return InvoiceItem(
      product: product ?? this.product,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }
}