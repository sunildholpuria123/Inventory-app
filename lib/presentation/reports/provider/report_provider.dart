import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedReportFilterProvider =
StateProvider<String>(
      (ref) => 'Monthly',
);

final totalSalesProvider =
Provider<double>((ref) {
  return 150000;
});

final totalExpenseProvider =
Provider<double>((ref) {
  return 50000;
});

final totalProfitProvider =
Provider<double>((ref) {
  final sales = ref.watch(
    totalSalesProvider,
  );

  final expenses = ref.watch(
    totalExpenseProvider,
  );

  return sales - expenses;
});