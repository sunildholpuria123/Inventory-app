import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_loyality_provider.dart';

class CustomerLoyaltyCard extends ConsumerWidget {
  final Customer customer;

  const CustomerLoyaltyCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyalty = ref.watch(customerLoyaltyProvider(customer.id));

    return loyalty.when(
      data: (data) {
        final points = data?.points ?? 0;

        final tier = data?.tier ?? 'Bronze';

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xffF59E0B), Color(0xffF97316)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$tier Member',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '$points Points',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
  }
}
