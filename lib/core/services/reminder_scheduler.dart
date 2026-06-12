import 'package:flutter_riverpod/flutter_riverpod.dart' show WidgetRef;

import '../../data/database/app_database.dart';
import '../../data/providers/database_provider.dart';
import '../../presentation/reminders/provider/reminder_provider.dart' show reminderRepositoryProvider;
import 'notification_service.dart';
import 'package:drift/drift.dart';

class ReminderScheduler {
  static Future<void> checkReminders(WidgetRef ref) async {
    final repo = ref.read(reminderRepositoryProvider);

    final db = ref.read(databaseProvider);

    final invoices = await repo.getInvoicesToRemind();

    for (final invoice in invoices) {
      await NotificationService.instance.showReminder(
        id: invoice.id,

        title: 'Payment Due Tomorrow',

        body: '${invoice.customerName} - ₹${invoice.dueAmount}',
      );

      /// MARK AS REMINDER SENT
      await (db.update(db.invoices)..where((tbl) => tbl.id.equals(invoice.id)))
          .write( InvoicesCompanion(reminderSent: Value(true)));
    }
  }
}
