import 'package:drift/drift.dart';

class CustomerNotes extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  IntColumn get customerId =>
      integer()();

  TextColumn get note =>
      text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}