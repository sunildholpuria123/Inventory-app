import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_return_dashboard_provider.dart';
import 'dashboard_stat_card.dart';

class PendingRefundsCard extends ConsumerWidget {
  const PendingRefundsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingRefunds = ref.watch(pendingRefundsProvider);

    return pendingRefunds.when(
      data: (amount) {
        return DashboardStatCard(
          title: 'Pending Refunds',

          value: 'Rs.${amount.toStringAsFixed(0)}',

          icon: Icons.pending_actions,

          color: Colors.red,
        );
      },

      loading: () => const DashboardStatCard(
        title: 'Pending Refunds',

        value: '...',

        icon: Icons.pending_actions,

        color: Colors.red,
      ),

      error: (_, __) => const DashboardStatCard(
        title: 'Pending Refunds',

        value: '0',

        icon: Icons.pending_actions,

        color: Colors.red,
      ),
    );
  }
}
