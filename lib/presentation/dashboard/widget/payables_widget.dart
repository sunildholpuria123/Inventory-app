import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../suppliers/provider/supplier_provider.dart';
import '../provider/dashboard_provider.dart';
import 'dashboard_stat_card.dart';

class PayablesWidget extends ConsumerWidget {
  const PayablesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payables = ref.watch(totalPayablesProvider);

    return payables.when(
      data: (amount) {
        return  DashboardStatCard(
          title: 'Payables',
          value: 'Rs.${amount.toStringAsFixed(0)}',
          icon: Icons.account_balance,
          color: Colors.red,
        );
      },

      loading: () {
        return  DashboardStatCard(
          title: 'Payables',
          value: '...',
          icon: Icons.account_balance,
          color: Colors.red,
        );
      },

      error: (_, __) {
        return  DashboardStatCard(
          title: 'Payables',
          value: 'Rs.0',
          icon: Icons.account_balance,
          color: Colors.red,
        );
      },
    );
  }
}
