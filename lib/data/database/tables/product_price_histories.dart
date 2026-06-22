import 'package:drift/drift.dart';

class ProductPriceHistories extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer()();

  IntColumn get supplierId => integer().nullable()();

  RealColumn get oldPurchasePrice => real()();

  RealColumn get newPurchasePrice => real()();

  RealColumn get oldSellingPrice => real()();

  RealColumn get newSellingPrice => real()();

  RealColumn get inflationPercentage =>
      real().withDefault(
        const Constant(0),
      )();

  DateTimeColumn get changedAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();

  TextColumn get remarks =>
      text().nullable()();
}