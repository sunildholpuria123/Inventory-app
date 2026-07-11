import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  RealColumn get amount => real()();

  TextColumn get category => text()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncId => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}
