import '../../../data/database/app_database.dart';
import 'package:drift/drift.dart';


class CustomerLoyaltyRepository {
  final AppDatabase db;

  CustomerLoyaltyRepository(this.db);

  Stream<CustomerLoyalty?> watchCustomerLoyalty(int customerId) {
    return (db.select(
      db.customerLoyalties,
    )..where((t) => t.customerId.equals(customerId))).watchSingleOrNull();
  }

  Future<void> addPoints({required int customerId, required int points}) async {
    final existing = await (db.select(
      db.customerLoyalties,
    )..where((t) => t.customerId.equals(customerId))).getSingleOrNull();

    if (existing == null) {
      await db
          .into(db.customerLoyalties)
          .insert(
            CustomerLoyaltiesCompanion.insert(
              customerId: customerId,
              points: Value(points),
              tier: Value(calculateTier(points)),
            ),
          );

      return;
    }

    final total = existing.points + points;

    await (db.update(
      db.customerLoyalties,
    )..where((t) => t.id.equals(existing.id))).write(
      CustomerLoyaltiesCompanion(
        points: Value(total),
        tier: Value(calculateTier(total)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  String calculateTier(int points) {
    if (points >= 5000) {
      return 'Platinum';
    }

    if (points >= 1500) {
      return 'Gold';
    }

    if (points >= 500) {
      return 'Silver';
    }

    return 'Bronze';
  }
}
