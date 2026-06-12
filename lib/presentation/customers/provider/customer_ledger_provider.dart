import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';

final customerLedgerProvider = FutureProvider.family<List<Invoice>, String>((
  ref,
  customerPhone,
) async {
  final db = ref.watch(databaseProvider);

  return (db.select(db.invoices)
        ..where((tbl) => tbl.customerPhone.equals(customerPhone))
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
      .get();
});
