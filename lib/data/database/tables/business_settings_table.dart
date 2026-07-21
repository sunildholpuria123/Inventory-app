import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

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

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncId => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  BoolColumn get enableUpiPayment =>
      boolean().withDefault(const Constant(false))();

  TextColumn get upiMerchantName => text().nullable()();
  TextColumn get stampPath => text().nullable()();
  TextColumn get signaturePath => text().nullable()();

  TextColumn get upiQrImagePath => text().nullable()();
}
