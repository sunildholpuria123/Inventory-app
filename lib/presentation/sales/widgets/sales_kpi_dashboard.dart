import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_kpi_provider.dart';
import 'sales_analytics_card.dart';

class SalesKpiDashboard extends ConsumerWidget {
  const SalesKpiDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpi = ref.watch(salesKpiProvider);

    return kpi.when(
      data: (data) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: 250,
              child: SalesAnalyticsCard(
                title: 'Revenue',
                value: '₹${data.totalRevenue.toStringAsFixed(0)}',
                icon: Icons.payments,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 250,
              child: SalesAnalyticsCard(
                title: 'Collected',
                value: '₹${data.totalCollected.toStringAsFixed(0)}',
                icon: Icons.check_circle,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 250,
              child: SalesAnalyticsCard(
                title: 'Due',
                value: '₹${data.totalDue.toStringAsFixed(0)}',
                icon: Icons.warning,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              width: 250,
              child: SalesAnalyticsCard(
                title: 'Invoices',
                value: data.totalInvoices.toString(),
                icon: Icons.receipt_long,
                color: Colors.purple,
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
