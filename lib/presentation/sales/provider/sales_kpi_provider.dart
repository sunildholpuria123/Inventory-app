import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_history_provider.dart';

class SalesKpi {
  final double totalRevenue;
  final double totalCollected;
  final double totalDue;
  final int totalInvoices;

  const SalesKpi({
    required this.totalRevenue,
    required this.totalCollected,
    required this.totalDue,
    required this.totalInvoices,
  });
}

final salesKpiProvider = FutureProvider<SalesKpi>((ref) async {
  final invoices = await ref.watch(salesHistoryProvider.future);

  double revenue = 0;
  double collected = 0;
  double due = 0;

  for (final e in invoices) {
    revenue += e.grandTotal;
    collected += e.amountPaid;
    due += e.dueAmount;
  }

  return SalesKpi(
    totalRevenue: revenue,
    totalCollected: collected,
    totalDue: due,
    totalInvoices: invoices.length,
  );
});
