import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/core/provider/database_provider.dart';

import '../../suppliers/provider/supplier_provider.dart';
import '../model/payable_data.dart';

final payablesProvider = FutureProvider<List<PayableData>>((ref) async {
  final repo = ref.read(supplierRepositoryProvider);

  final suppliers = await repo.getAllSuppliers();

  final result = suppliers
      .where((s) => s.creditBalance > 0)
      .map((e) => PayableData(supplier: e, amount: e.creditBalance))
      .toList();

  result.sort((a, b) => b.amount.compareTo(a.amount));

  return result;
});
