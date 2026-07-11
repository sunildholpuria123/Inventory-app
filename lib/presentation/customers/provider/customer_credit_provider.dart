import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_provider.dart';

class CustomerCreditData {
  final double totalDue;
  final int customersWithDue;
  final double averageDue;

  const CustomerCreditData({
    required this.totalDue,
    required this.customersWithDue,
    required this.averageDue,
  });
}

final customerCreditProvider = FutureProvider<CustomerCreditData>((ref) async {
  final customers = await ref.watch(customersProvider.future);

  double totalDue = 0;
  int dueCustomers = 0;

  for (final customer in customers) {
    final due = customer.creditBalance ?? 0;

    if (due > 0) {
      dueCustomers++;
      totalDue += due;
    }
  }

  return CustomerCreditData(
    totalDue: totalDue,
    customersWithDue: dueCustomers,
    averageDue: dueCustomers == 0 ? 0 : totalDue / dueCustomers,
  );
});
