import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../model/customer_timeline_Item.dart';
import 'customer_provider.dart';

class CustomerDashboardData {
  final int totalCustomers;

  const CustomerDashboardData({required this.totalCustomers});
}

final customerDashboardProvider = FutureProvider<CustomerDashboardData>((
  ref,
) async {
  final customers = await ref.watch(customersProvider.future);

  return CustomerDashboardData(totalCustomers: customers.length);
});

final recentPaymentsProvider = StreamProvider<List<PaymentHistory>>((ref) {
  final db = ref.watch(databaseProvider);

  return (db.select(db.paymentHistories)
    ..orderBy([
          (tbl) => OrderingTerm.desc(tbl.paidAt),
    ])
    ..limit(10))
      .watch();
});

final customerTimelineProvider =
FutureProvider<List<CustomerTimelineItem>>((ref) async {
  final db = ref.watch(databaseProvider);

  final customers = await db.select(db.customers).get();
  final invoices = await db.select(db.invoices).get();
  final payments = await db.select(db.paymentHistories).get();

  final List<CustomerTimelineItem> timeline = [];

  /// Customers
  for (final customer in customers) {
    timeline.add(
      CustomerTimelineItem(
        customerId: customer.id,
        title: customer.name,
        subtitle: 'Customer Added',
        date: customer.createdAt,
        icon: Icons.person_add,
      ),
    );
  }

  /// Invoices
  for (final invoice in invoices) {
    timeline.add(
      CustomerTimelineItem(
        customerId: invoice.customerId,
        title: invoice.invoiceNo,
        subtitle: 'Invoice Created',
        date: invoice.createdAt,
        icon: Icons.receipt_long,
      ),
    );
  }

  /// Payments
  for (final payment in payments) {
    timeline.add(
      CustomerTimelineItem(
        customerId: payment.customerId,
        title: '₹${payment.amount.toStringAsFixed(0)}',
        subtitle: 'Payment Received',
        date: payment.paidAt,
        icon: Icons.payments,
      ),
    );
  }

  timeline.sort(
        (a, b) => b.date.compareTo(a.date),
  );

  return timeline.take(20).toList();
});