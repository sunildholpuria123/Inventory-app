class PriceRecommendationModel {
  final String productName;
  final double currentPurchase;
  final double recommendedPurchase;
  final double recommendedSelling;

  const PriceRecommendationModel({
    required this.productName,
    required this.currentPurchase,
    required this.recommendedPurchase,
    required this.recommendedSelling,
  });
}