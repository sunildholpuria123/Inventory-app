import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

class SyncUpsertHelper {
  const SyncUpsertHelper._();

  static Future<void> upsert<T extends Table, D>({
    required AppDatabase db,
    required TableInfo<T, D> table,
    required Insertable<D> companion,
  }) async {
    await db.into(table).insertOnConflictUpdate(companion);
  }
}