class InventoryAnalytics {
  final int lowStock;
  final int healthyStock;
  final int overStock;
  final double totalValue;

  const InventoryAnalytics({
    required this.lowStock,
    required this.healthyStock,
    required this.overStock,
    required this.totalValue,
  });
}