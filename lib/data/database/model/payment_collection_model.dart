class PaymentCollectionModel {
  final double collected;
  final double due;

  const PaymentCollectionModel({
    required this.collected,
    required this.due,
  });

  double get total => collected + due;

  double get collectionPercentage =>
      total == 0 ? 0 : (collected / total) * 100;
}