import 'package:drift/drift.dart';

class SyncHistories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get deviceId => text()();

  TextColumn get deviceName => text()();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  IntColumn get sentRecords => integer().withDefault(const Constant(0))();

  IntColumn get receivedRecords => integer().withDefault(const Constant(0))();

  TextColumn get status => text()();

  TextColumn get message => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}