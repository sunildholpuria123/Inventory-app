class ReorderSuggestionModel {
  final int productId;
  final String productName;
  final int stock;
  final int suggestedQty;

  const ReorderSuggestionModel({
    required this.productId,
    required this.productName,
    required this.stock,
    required this.suggestedQty,
  });
}