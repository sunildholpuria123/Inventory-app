import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';

class SyncHistoryRepository {
  final AppDatabase db;

  const SyncHistoryRepository(this.db);

  Future<int> start({
    required String deviceId,
    required String deviceName,
  }) {
    return db.into(db.syncHistories).insert(
      SyncHistoriesCompanion.insert(
        deviceId: deviceId,
        deviceName: deviceName,
        startedAt: DateTime.now(),
        status: 'RUNNING',
      ),
    );
  }

  Future<void> complete({
    required int id,
    required int sent,
    required int received,
  }) {
    return (db.update(db.syncHistories)
      ..where((t) => t.id.equals(id)))
        .write(
      SyncHistoriesCompanion(
        completedAt: Value(DateTime.now()),
        sentRecords: Value(sent),
        receivedRecords: Value(received),
        status: const Value('SUCCESS'),
      ),
    );
  }

  Future<void> failed({
    required int id,
    required String error,
  }) {
    return (db.update(db.syncHistories)
      ..where((t) => t.id.equals(id)))
        .write(
      SyncHistoriesCompanion(
        completedAt: Value(DateTime.now()),
        status: const Value('FAILED'),
        message: Value(error),
      ),
    );
  }
}