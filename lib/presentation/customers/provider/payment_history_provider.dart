import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';

final paymentHistoryProvider = StreamProvider.family<List<PaymentHistory>, int>(
  (ref, invoiceId) {
    final db = ref.watch(databaseProvider);

    return (db.select(db.paymentHistories)
          ..where((tbl) => tbl.invoiceId.equals(invoiceId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.paidAt)]))
        .watch();
  },
);
