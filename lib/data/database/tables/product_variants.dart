import 'package:drift/drift.dart';
import 'package:inventory_desktop/data/database/tables/products_table.dart';


class ProductVariants extends Table {

  IntColumn get id =>
      integer().autoIncrement()();

  IntColumn get productId =>
      integer().references(
        Products,
        #id,
      )();

  TextColumn get variantName =>
      text()();

  TextColumn get thickness =>
      text().nullable()();

  TextColumn get color =>
      text().nullable()();

  TextColumn get size =>
      text().nullable()();

  RealColumn get purchasePrice =>
      real()();

  RealColumn get sellingPrice =>
      real()();

  RealColumn get stockQty =>
      real()();

  BoolColumn get isActive =>
      boolean().withDefault(
        const Constant(
          true,
        ),
      )();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(
        currentDateAndTime,
      )();
}