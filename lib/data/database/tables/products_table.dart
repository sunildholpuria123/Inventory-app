import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer()();

  TextColumn get name => text()();

  TextColumn get sku => text().nullable()();

  TextColumn get barcode => text().nullable()();

  RealColumn get purchasePrice => real()();

  RealColumn get sellingPrice => real()();

  IntColumn get stockQty => integer()();

  IntColumn get minStock => integer()();

  TextColumn get imagePath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncId => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}
