import 'package:drift/drift.dart';

class CustomerDocuments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer()();

  TextColumn get name => text()();

  TextColumn get filePath => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
