import 'package:drift/drift.dart';

class CustomerLoyalties extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  IntColumn get customerId =>
      integer()();

  IntColumn get points =>
      integer().withDefault(
        const Constant(0),
      )();

  TextColumn get tier =>
      text().withDefault(
        const Constant(
          'Bronze',
        ),
      )();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}