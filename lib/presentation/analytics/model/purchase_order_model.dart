class PurchaseOrderModel {
  final int productId;
  final String productName;
  final String supplierName;
  final int quantity;
  final double estimatedCost;

  const PurchaseOrderModel({
    required this.productId,
    required this.productName,
    required this.supplierName,
    required this.quantity,
    required this.estimatedCost,
  });
}