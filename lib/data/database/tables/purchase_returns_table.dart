import 'package:drift/drift.dart';

class PurchaseReturns extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get purchaseId => integer()();

  IntColumn get supplierId => integer()();

  IntColumn get productId => integer()();

  IntColumn get variantId => integer().nullable()();

  TextColumn get reason => text()();

  IntColumn get quantity => integer()();

  RealColumn get amount => real()();

  TextColumn get refundStatus =>
      text().withDefault(const Constant('PENDING'))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
