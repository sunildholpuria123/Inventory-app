enum TransactionType {
  sale,
  purchase,
  expense,
  customerPayment,
  supplierPayment,
}

class TransactionTimelineItem {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  const TransactionTimelineItem({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });
}