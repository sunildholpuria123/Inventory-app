import 'package:drift/drift.dart';

class SupplierPaymentHistories extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supplierId => integer()();

  IntColumn get purchaseId => integer().nullable()();

  RealColumn get amount => real()();

  TextColumn get paymentMethod => text().withDefault(const Constant('Cash'))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
