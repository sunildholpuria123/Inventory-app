import 'package:drift/drift.dart';

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get invoiceNo => text()();

  TextColumn get customerName => text()();

  TextColumn get customerPhone => text()();

  RealColumn get subtotal => real()();

  RealColumn get tax => real()();

  RealColumn get discount => real().withDefault(const Constant(0))();

  RealColumn get grandTotal => real()();

  TextColumn get paymentMethod => text().withDefault(const Constant('CASH'))();

  TextColumn get paymentStatus => text().withDefault(const Constant('PAID'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get pdfPath => text().nullable()();

  RealColumn get amountPaid => real().withDefault(const Constant(0))();

  RealColumn get dueAmount => real().withDefault(const Constant(0))();

  DateTimeColumn get dueDate => dateTime().nullable()();

  BoolColumn get reminderSent => boolean().withDefault(const Constant(false))();

  RealColumn get loadingCharge => real().withDefault(const Constant(0))();

  RealColumn get unloadingCharge => real().withDefault(const Constant(0))();

  RealColumn get transportCharge => real().withDefault(const Constant(0))();
}
