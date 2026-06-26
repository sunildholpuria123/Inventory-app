import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_provider.dart';
import '../../sales/provider/sales_history_provider.dart';

class CustomerInsights {
  final int totalCustomers;
  final int activeCustomers;
  final int inactiveCustomers;

  const CustomerInsights({
    required this.totalCustomers,
    required this.activeCustomers,
    required this.inactiveCustomers,
  });
}

final customerInsightsProvider = FutureProvider<CustomerInsights>((ref) async {
  final customers = await ref.watch(customersProvider.future);

  final invoices = await ref.watch(salesHistoryProvider.future);

  final activeCustomerIds = invoices.map((e) => e.customerId).toSet();

  final active = customers
      .where((c) => activeCustomerIds.contains(c.id))
      .length;

  return CustomerInsights(
    totalCustomers: customers.length,
    activeCustomers: active,
    inactiveCustomers: customers.length - active,
  );
});
