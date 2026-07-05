import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../../../data/database/app_database.dart';

class CustomerPaymentsTab extends ConsumerWidget {
  final Customer customer;

  const CustomerPaymentsTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    final paymentsProvider = StreamProvider((ref) {
      return (db.select(db.paymentHistories)
            ..where((tbl) => tbl.customerId.equals(customer.id))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.paidAt)]))
          .watch();
    });

    final payments = ref.watch(paymentsProvider);

    return payments.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('No Payments'));
        }

        double total = items.fold(0, (sum, e) => sum + e.amount);

        return Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              child: ListTile(
                leading: const Icon(Icons.payments, color: Colors.green),
                title: const Text('Total Payments'),
                trailing: Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final payment = items[index];

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.payments)),
                      title: Text('₹${payment.amount.toStringAsFixed(0)}'),
                      subtitle: Text(
                        payment.paidAt.toString().substring(0, 16),
                      ),
                      trailing: Text(payment.paymentMethod),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}
