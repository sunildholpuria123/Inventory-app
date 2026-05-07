import 'package:drift/drift.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get phone => text()();

  TextColumn get email =>
      text().nullable()();

  TextColumn get address =>
      text().nullable()();
}