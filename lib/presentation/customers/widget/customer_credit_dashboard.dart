import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/customer_credit_provider.dart';
import 'customer_kpi_card.dart';

class CustomerCreditDashboard extends ConsumerWidget {
  const CustomerCreditDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credit = ref.watch(customerCreditProvider);

    return credit.when(
      data: (data) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: 260,
              child: CustomerKpiCard(
                title: 'Total Due',
                value: '₹${data.totalDue.toStringAsFixed(0)}',
                icon: Icons.account_balance_wallet,
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: 260,
              child: CustomerKpiCard(
                title: 'Due Customers',
                value: '${data.customersWithDue}',
                icon: Icons.warning,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              width: 260,
              child: CustomerKpiCard(
                title: 'Average Due',
                value: '₹${data.averageDue.toStringAsFixed(0)}',
                icon: Icons.trending_up,
                color: Colors.blue,
              ),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
  }
}
