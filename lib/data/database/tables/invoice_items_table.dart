import 'package:drift/drift.dart';

class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// INVOICE ID
  IntColumn get invoiceId => integer()();

  /// PRODUCT ID
  IntColumn get productId => integer()();

  /// PRODUCT NAME SNAPSHOT
  TextColumn get productName => text()();

  /// QUANTITY
  IntColumn get quantity => integer()();

  /// PRICE AT SALE TIME
  RealColumn get price => real()();

  /// TOTAL
  RealColumn get total => real()();

  /// CREATED DATE
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
