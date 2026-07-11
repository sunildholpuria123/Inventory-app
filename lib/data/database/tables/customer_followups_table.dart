import 'package:drift/drift.dart';

class CustomerFollowUps extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get followUpDate => dateTime()();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
