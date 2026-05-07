import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get email => text().unique()();

  TextColumn get password => text()();

  TextColumn get role => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}