import 'package:drift/drift.dart';

class PaymentHistories extends Table {

  IntColumn get id =>
      integer().autoIncrement()();

  IntColumn get invoiceId =>
      integer()();

  IntColumn get customerId =>
      integer()();

  RealColumn get amount =>
      real()();

  TextColumn get paymentMethod =>
      text().withDefault(
        const Constant(
          'Cash',
        ),
      )();

  TextColumn get notes =>
      text().nullable()();

  DateTimeColumn get paidAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}