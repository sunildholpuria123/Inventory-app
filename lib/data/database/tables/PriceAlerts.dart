import 'package:drift/drift.dart';

class PriceAlerts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer()();

  RealColumn get oldPrice => real()();

  RealColumn get newPrice => real()();

  RealColumn get increasePercentage => real()();

  BoolColumn get isRead =>
      boolean().withDefault(
        const Constant(false),
      )();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}