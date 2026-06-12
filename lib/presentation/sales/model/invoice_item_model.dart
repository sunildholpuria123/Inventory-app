import '../../../data/database/app_database.dart';

class InvoiceItemModel {
  final Product product;

  final int qty;

  final double price;

  InvoiceItemModel({
    required this.product,
    required this.qty,
    required this.price,
  });

  double get total => qty * price;

  String get productName => product.name;
}
