import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_history_provider.dart';

class MonthlySale {
  final String month;
  final double amount;

  const MonthlySale({
    required this.month,
    required this.amount,
  });
}

class CustomerSales {
  final int? customerId;
  final String customer;
  final double amount;

  const CustomerSales({
    required this.customerId,
    required this.customer,
    required this.amount,
  });
}

final monthlySalesProvider =
FutureProvider<List<MonthlySale>>((ref) async {
  final invoices =
  await ref.watch(
    salesHistoryProvider.future,
  );

  final map = <String, double>{};

  for (final e in invoices) {
    final key =
        '${e.createdAt.year}-${e.createdAt.month.toString().padLeft(2, '0')}';

    map[key] =
        (map[key] ?? 0) +
            e.grandTotal;
  }

  return map.entries
      .map(
        (e) => MonthlySale(
      month: e.key,
      amount: e.value,
    ),
  )
      .toList();
});

final topCustomersProvider =
FutureProvider<List<CustomerSales>>((ref) async {
  final invoices = await ref.watch(salesHistoryProvider.future);

  final Map<int, CustomerSales> map = {};

  for (final invoice in invoices) {
    final customerId = invoice.customerId;

    if (customerId == null) {
      continue;
    }

    final existing = map[customerId];

    if (existing == null) {
      map[customerId] = CustomerSales(
        customerId: customerId,
        customer: invoice.customerName,
        amount: invoice.grandTotal,
      );
    } else {
      map[customerId] = CustomerSales(
        customerId: existing.customerId,
        customer: existing.customer,
        amount: existing.amount + invoice.grandTotal,
      );
    }
  }

  final list = map.values.toList();

  list.sort(
        (a, b) => b.amount.compareTo(a.amount),
  );

  return list.take(10).toList();
});

final dueInvoicesProvider =
FutureProvider((ref) async {
  final invoices =
  await ref.watch(
    salesHistoryProvider.future,
  );

  return invoices
      .where(
        (e) => e.dueAmount > 0,
  )
      .toList();
});