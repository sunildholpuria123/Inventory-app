import 'package:drift/drift.dart';

class InvoiceItems extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  IntColumn get invoiceId =>
      integer()();

  IntColumn get productId =>
      integer()();

  TextColumn get productName =>
      text()();

  IntColumn get qty =>
      integer()();

  RealColumn get price =>
      real()();

  RealColumn get subtotal =>
      real()();
}