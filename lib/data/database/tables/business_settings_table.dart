import 'package:drift/drift.dart';

class BusinessSettings extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get companyName => text()();

  TextColumn get ownerName => text().nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get address => text().nullable()();

  TextColumn get gstNo => text().nullable()();

  TextColumn get logoPath => text().nullable()();

  TextColumn get bankName => text().nullable()();

  TextColumn get accountNumber => text().nullable()();

  TextColumn get ifscCode => text().nullable()();

  TextColumn get upiId => text().nullable()();

  TextColumn get footerMessage => text().nullable()();
}
