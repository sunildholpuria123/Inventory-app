import 'package:drift/drift.dart';

class PurchaseItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// PURCHASE ID
  IntColumn get purchaseId => integer()();

  /// PRODUCT ID
  IntColumn get productId => integer()();

  /// PRODUCT NAME SNAPSHOT
  TextColumn get productName => text()();

  /// QUANTITY
  IntColumn get quantity => integer()();

  /// PURCHASE PRICE
  RealColumn get purchasePrice => real()();

  /// TOTAL
  RealColumn get total => real()();

  /// CREATED DATE
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
