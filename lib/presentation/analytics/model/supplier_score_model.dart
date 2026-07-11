class SupplierScoreModel {
  final String supplierName;
  final double score;
  final double totalPurchase;
  final double returnRate;

  const SupplierScoreModel({
    required this.supplierName,
    required this.score,
    required this.totalPurchase,
    required this.returnRate,
  });
}