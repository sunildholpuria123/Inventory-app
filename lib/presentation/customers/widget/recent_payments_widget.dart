import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../provider/customer_provider.dart';
import '../screen/customer_profile_screen.dart';

final recentPaymentsProvider =
StreamProvider<List<PaymentHistory>>((ref) {
  final db = ref.watch(databaseProvider);

  return (db.select(db.paymentHistories)
    ..orderBy([
          (tbl) => OrderingTerm.desc(tbl.paidAt),
    ])
    ..limit(5))
      .watch();
});

class RecentPaymentsWidget extends ConsumerWidget {
  const RecentPaymentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payments = ref.watch(recentPaymentsProvider);
    final customers = ref.watch(customersProvider);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: payments.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),

          error: (e, _) => SizedBox(
            height: 120,
            child: Center(
              child: Text(e.toString()),
            ),
          ),

          data: (paymentList) {
            return customers.when(
              loading: () => const SizedBox(
                height: 120,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

              error: (e, _) => SizedBox(
                height: 120,
                child: Center(
                  child: Text(e.toString()),
                ),
              ),

              data: (customerList) {
                if (paymentList.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Payments',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No recent payments',
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.payments,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Recent Payments',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ...paymentList.map((payment) {
                      Customer? customer;

                      try {
                        final customer = customerList.cast().firstWhere(
                              (e) => e.id == payment.customerId,
                          orElse: () => customerList.first,
                        );
                      } catch (_) {}

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              customer?.name.substring(0, 1).toUpperCase() ??
                                  "?",
                            ),
                          ),

                          title: Text(
                            customer?.name ?? "Unknown Customer",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                payment.paymentMethod,
                              ),
                              Text(
                                payment.paidAt
                                    .toString()
                                    .substring(0, 16),
                              ),
                            ],
                          ),

                          trailing: Text(
                            "₹${payment.amount.toStringAsFixed(0)}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          onTap: customer == null
                              ? null
                              : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CustomerProfileScreen(
                                      customer: customer!,
                                    ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}