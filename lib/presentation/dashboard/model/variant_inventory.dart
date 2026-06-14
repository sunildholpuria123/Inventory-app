class VariantInventory {
  final String productName;

  final String variantName;

  final double stock;

  final double sold;

  final bool lowStock;

  final bool deadStock;

  final bool fastMoving;

  VariantInventory({
    required this.productName,
    required this.variantName,
    required this.stock,
    required this.sold,
    required this.lowStock,
    required this.deadStock,
    required this.fastMoving,
  });
}
