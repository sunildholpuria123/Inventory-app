import 'package:drift/drift.dart';

class PurchaseItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get purchaseId => integer()();

  IntColumn get productId => integer()();

  IntColumn get qty => integer()();

  RealColumn get price => real()();
}