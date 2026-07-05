import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/core/provider/database_provider.dart';

import '../model/receivable_data.dart';

final receivablesProvider = FutureProvider<List<ReceivableData>>((ref) async {
  final repo = ref.read(appDatabaseProvider);

  final customers = await repo.getAllCustomers();

  final result = customers
      .where((c) => c.creditBalance > 0)
      .map((e) => ReceivableData(customer: e, amount: e.creditBalance))
      .toList();

  result.sort((a, b) => b.amount.compareTo(a.amount));

  return result;
});
