import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/sales/provider/sales_analytics_provider.dart';


class CustomerLifetimeValue {
  final String customer;
  final double value;

  const CustomerLifetimeValue({required this.customer, required this.value});
}

final customerLifetimeValueProvider =
    FutureProvider<List<CustomerLifetimeValue>>((ref) async {
      final customers = await ref.watch(topCustomersProvider.future);

      return customers
          .map(
            (e) => CustomerLifetimeValue(customer: e.customer, value: e.amount),
          )
          .toList();
    });
