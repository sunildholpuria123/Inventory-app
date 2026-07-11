class InventoryOptimizationModel {
  final int productId;
  final String productName;
  final int currentStock;
  final int optimalStock;
  final int reorderQty;

  const InventoryOptimizationModel({
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.optimalStock,
    required this.reorderQty,
  });
}