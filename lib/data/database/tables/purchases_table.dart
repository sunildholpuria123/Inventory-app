import 'package:drift/drift.dart';

class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// PURCHASE NO
  TextColumn get purchaseNo => text()();

  /// SUPPLIER NAME
  TextColumn get supplierName => text()();

  /// PHONE
  TextColumn get supplierPhone => text().nullable()();

  /// TOTAL
  RealColumn get total => real()();

  /// PDF PATH
  TextColumn get pdfPath => text().nullable()();

  /// CREATED DATE
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
