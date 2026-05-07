import 'package:drift/drift.dart';

class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer()();

  TextColumn get invoiceNo => text()();

  RealColumn get total => real()();

  RealColumn get discount => real()();

  RealColumn get tax => real()();

  RealColumn get grandTotal => real()();

  TextColumn get paymentStatus => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}