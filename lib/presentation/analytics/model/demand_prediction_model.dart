class DemandPredictionModel {
  final int productId;
  final String productName;
  final int predictedQty;

  const DemandPredictionModel({
    required this.productId,
    required this.productName,
    required this.predictedQty,
  });
}