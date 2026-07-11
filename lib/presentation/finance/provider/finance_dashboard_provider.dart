import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../customers/provider/customer_provider.dart';
import '../../expenses/provider/expense_provider.dart';
import '../../sales/provider/sales_repository_provider.dart';
import '../../suppliers/provider/supplier_provider.dart';
import '../model/finance_dashboard_data.dart';

final financeDashboardProvider = FutureProvider<FinanceDashboardData>((
  ref,
) async {
  final salesRepo = ref.read(salesRepositoryProvider);

  final expenseRepo = ref.read(expenseRepositoryProvider);

  final customerRepo = ref.read(customerRepositoryProvider);

  final supplierRepo = ref.read(supplierRepositoryProvider);

  final invoices = await salesRepo.getAllInvoices();

  final expenses = await ref.watch(expensesProvider.future);

  final customers = await ref.watch(customersProvider.future);

  final suppliers = await ref.watch(suppliersProvider.future);

  double revenue = 0;
  double expenseTotal = 0;
  double receivables = 0;
  double payables = 0;

  for (final invoice in invoices) {
    revenue += invoice.grandTotal;
  }

  for (final expense in expenses) {
    expenseTotal += expense.amount;
  }

  for (final customer in customers) {
    receivables += customer.creditBalance;
  }

  for (final supplier in suppliers) {
    payables += supplier.creditBalance;
  }

  return FinanceDashboardData(
    revenue: revenue,
    expenses: expenseTotal,
    profit: revenue - expenseTotal,
    receivables: receivables,
    payables: payables,
  );
});

