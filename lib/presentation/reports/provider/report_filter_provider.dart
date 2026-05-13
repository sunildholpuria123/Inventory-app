import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/report_filter_model.dart';

final reportFilterProvider =
StateProvider<ReportFilterModel>(
      (ref) {
    return ReportFilterModel();
  },
);