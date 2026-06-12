import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';

final outstandingProvider =
StreamProvider<double>((ref) {

  final db =
  ref.watch(
    databaseProvider,
  );

  return db.customSelect(
      '''
    SELECT
    COALESCE(
      SUM(due_amount),
      0
    ) AS total

    FROM invoices

    WHERE due_amount > 0
    '''
  )
      .watch()
      .map(
        (rows) =>
        (rows.first.data[
        'total']
        as num)
            .toDouble(),
  );
});