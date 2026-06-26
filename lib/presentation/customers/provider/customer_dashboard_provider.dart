import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_provider.dart';

class CustomerDashboardData {
  final int totalCustomers;

  const CustomerDashboardData({required this.totalCustomers});
}

final customerDashboardProvider = FutureProvider<CustomerDashboardData>((
  ref,
) async {
  final customers = await ref.watch(customersProvider.future);

  return CustomerDashboardData(totalCustomers: customers.length);
});
