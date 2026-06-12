import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';

final paymentHistoryProvider = FutureProvider.family((ref, int invoiceId) {
  final db = ref.watch(databaseProvider);

  return (db.select(db.paymentHistories)
        ..where((tbl) => tbl.invoiceId.equals(invoiceId))
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.paidAt)]))
      .get();
});
