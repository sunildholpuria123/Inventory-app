import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// INVOICE ID
  IntColumn get invoiceId => integer()();

  /// PRODUCT ID
  IntColumn get productId => integer()();

  /// VARIANT ID
  IntColumn get variantId => integer().nullable()();

  /// PRODUCT NAME SNAPSHOT
  TextColumn get productName => text()();

  /// VARIANT NAME SNAPSHOT
  TextColumn get variantName => text().nullable()();

  /// QUANTITY
  IntColumn get quantity => integer()();

  /// PRICE AT SALE TIME
  RealColumn get price => real()();

  /// AREA PRODUCTS
  RealColumn get height => real().nullable()();

  RealColumn get width => real().nullable()();

  RealColumn get area => real().nullable()();

  /// TOTAL
  RealColumn get total => real()();

  /// CREATED DATE
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncId => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}
