import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_history_provider.dart';


class CustomerAnalytics {
  final int totalCustomers;
  final int repeatCustomers;
  final double averageOrderValue;

  const CustomerAnalytics({
    required this.totalCustomers,
    required this.repeatCustomers,
    required this.averageOrderValue,
  });
}

final customerAnalyticsProvider =
FutureProvider<CustomerAnalytics>(
      (ref) async {
    final invoices =
    await ref.watch(
      salesHistoryProvider.future,
    );

    final customerMap =
    <String, int>{};

    double totalRevenue = 0;

    for (final invoice
    in invoices) {
      totalRevenue +=
          invoice.grandTotal;

      customerMap[
      invoice.customerName] =
          (customerMap[
          invoice
              .customerName] ??
              0) +
              1;
    }

    final repeat =
        customerMap.values
            .where(
              (e) => e > 1,
        )
            .length;

    return CustomerAnalytics(
      totalCustomers:
      customerMap.length,
      repeatCustomers:
      repeat,
      averageOrderValue:
      invoices.isEmpty
          ? 0
          : totalRevenue /
          invoices.length,
    );
  },
);