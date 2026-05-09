class InvoiceItemModel {
  final String name;

  final int qty;

  final double price;

  final double subtotal;

  InvoiceItemModel({
    required this.name,
    required this.qty,
    required this.price,
    required this.subtotal,
  });
}
