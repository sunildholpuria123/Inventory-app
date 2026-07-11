import 'package:drift/drift.dart';

class SalesReturns extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get invoiceId => integer()();

  IntColumn get customerId => integer()();

  IntColumn get productId => integer()();

  IntColumn get variantId => integer().nullable()();

  IntColumn get quantity => integer()();

  RealColumn get amount => real()();

  TextColumn get reason => text()();

  TextColumn get refundStatus =>
      text().withDefault(const Constant('PENDING'))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
