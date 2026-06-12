import 'package:drift/drift.dart';

class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get saleId => integer()();

  IntColumn get productId => integer()();

  IntColumn get qty => integer()();

  RealColumn get price => real()();

  RealColumn get subtotal => real()();
}
