import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../expenses/provider/expense_provider.dart';
import '../../purchases/provider/purchase_provider.dart';
import '../../sales/provider/sales_history_provider.dart';
import '../../sales/provider/sales_provider.dart';
import '../model/cash_flow_data.dart';

final cashFlowProvider =
FutureProvider<CashFlowData>(
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

    double cashIn = 0;
    double cashOut = 0;

    for (final e in invoices) {
      cashIn += e.amountPaid;
    }

    for (final e in purchases) {
      cashOut += e.total;
    }

    for (final e in expenses) {
      cashOut += e.amount;
    }

    return CashFlowData(
      cashIn: cashIn,
      cashOut: cashOut,
      netCash:
      cashIn -
          cashOut,
    );
  },
);