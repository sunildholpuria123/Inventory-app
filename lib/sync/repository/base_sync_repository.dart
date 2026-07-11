import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';

abstract class BaseSyncRepository {
  final AppDatabase db;

  const BaseSyncRepository(this.db);

  //---------------------------------------------------------------------------
  // INSERT
  //---------------------------------------------------------------------------

  Future<void> insert<T extends Table, D>(
      TableInfo<T, D> table,
      Insertable<D> companion,
      ) async {
    await db.into(table).insert(companion);
  }

  //---------------------------------------------------------------------------
  // UPDATE
  //---------------------------------------------------------------------------

  Future<void> update<T extends Table, D>({
    required TableInfo<T, D> table,
    required Expression<bool> Function(T tbl) where,
    required Insertable<D> companion,
  }) async {
    await (db.update(table)..where(where)).write(companion);
  }

  //---------------------------------------------------------------------------
  // DELETE
  //---------------------------------------------------------------------------

  Future<void> delete<T extends Table, D>({
    required TableInfo<T, D> table,
    required Expression<bool> Function(T tbl) where,
  }) async {
    await (db.delete(table)..where(where)).go();
  }

  //---------------------------------------------------------------------------
  // UPSERT BY ID
  //---------------------------------------------------------------------------

  Future<void> upsert<T extends Table, D>({
    required TableInfo<T, D> table,
    required Insertable<D> companion,
  }) async {
    await db.into(table).insertOnConflictUpdate(companion);
  }

  //---------------------------------------------------------------------------
  // TRANSACTION
  //---------------------------------------------------------------------------

  Future<void> transaction(
      Future<void> Function() action,
      ) async {
    await db.transaction(action);
  }
}