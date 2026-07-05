import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../expenses/provider/expense_provider.dart';
import '../../purchases/provider/purchase_provider.dart';
import '../../sales/provider/sales_history_provider.dart';
import '../../sales/provider/sales_provider.dart';
import '../model/profit_loss_data.dart';

final profitLossProvider =
FutureProvider<ProfitLossData>(
      (ref) async {
    final invoices =
    await ref.watch(
      salesHistoryProvider.future,
    );

    final purchaseRepo =
    ref.read(
      purchaseRepositoryProvider,
    );
    final purchases =
    await purchaseRepo.getPurchases();

    final expenses =
    await ref.watch(
      expensesProvider.future,
    );

    double revenue = 0;
    double purchaseTotal = 0;
    double expenseTotal = 0;

    for (final e in invoices) {
      revenue += e.grandTotal;
    }

    for (final e in purchases) {
      purchaseTotal += e.total;
    }

    for (final e in expenses) {
      expenseTotal += e.amount;
    }

    final gross =
        revenue - purchaseTotal;

    final net =
        gross - expenseTotal;

    return ProfitLossData(
      revenue: revenue,
      purchases:
      purchaseTotal,
      expenses:
      expenseTotal,
      grossProfit:
      gross,
      netProfit:
      net,
    );
  },
);