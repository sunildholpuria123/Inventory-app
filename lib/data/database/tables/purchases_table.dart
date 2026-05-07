import 'package:drift/drift.dart';

class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supplierId => integer()();

  RealColumn get total => real()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}