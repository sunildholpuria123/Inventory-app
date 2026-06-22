class AiPurchaseAssistantModel {
  final String productName;
  final int currentStock;
  final int predictedDemand;
  final int suggestedPurchase;
  final String supplierName;
  final double estimatedCost;

  const AiPurchaseAssistantModel({
    required this.productName,
    required this.currentStock,
    required this.predictedDemand,
    required this.suggestedPurchase,
    required this.supplierName,
    required this.estimatedCost,
  });
}