import '../../../data/database/app_database.dart';

class ReceivableData {
  final Customer customer;
  final double amount;

  const ReceivableData({
    required this.customer,
    required this.amount,
  });
}