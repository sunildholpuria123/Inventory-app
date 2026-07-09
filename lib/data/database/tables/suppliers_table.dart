import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get phone => text()();

  TextColumn get email => text().nullable()();

  TextColumn get address => text().nullable()();

  RealColumn get creditBalance => real().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get gstNumber => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncId => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}
