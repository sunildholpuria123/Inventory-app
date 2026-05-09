import 'package:drift/drift.dart';

class Invoices extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  TextColumn get invoiceNo =>
      text()();

  IntColumn get customerId =>
      integer()();

  TextColumn get customerName =>
      text()();

  TextColumn get customerPhone =>
      text()();

  RealColumn get subtotal =>
      real()();

  RealColumn get tax =>
      real()();

  RealColumn get discount =>
      real()();

  RealColumn get grandTotal =>
      real()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}