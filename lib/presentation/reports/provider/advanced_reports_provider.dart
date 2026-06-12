import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/reports/provider/report_provider.dart'
    show reportsRepositoryProvider;

import '../provider/report_filter_provider.dart';

final filteredRevenueProvider = FutureProvider<double>((ref) async {
  final filter = ref.watch(reportFilterProvider);

  final repo = ref.watch(reportsRepositoryProvider);

  return repo.getFilteredRevenue(
    startDate: filter.startDate,

    endDate: filter.endDate,
  );
});
