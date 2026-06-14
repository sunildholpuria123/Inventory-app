import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_return_dashboard_provider.dart';
import 'dashboard_stat_card.dart';

class PurchaseReturnsCard extends ConsumerWidget {
  const PurchaseReturnsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseReturns = ref.watch(purchaseReturnsProvider);

    return purchaseReturns.when(
      data: (amount) {
        return DashboardStatCard(
          title: 'Purchase Returns',

          value: 'Rs.${amount.toStringAsFixed(0)}',

          icon: Icons.assignment_return,

          color: Colors.deepOrange,
        );
      },

      loading: () => const DashboardStatCard(
        title: 'Purchase Returns',

        value: '...',

        icon: Icons.assignment_return,

        color: Colors.deepOrange,
      ),

      error: (_, __) => const DashboardStatCard(
        title: 'Purchase Returns',

        value: '0',

        icon: Icons.assignment_return,

        color: Colors.deepOrange,
      ),
    );
  }
}
