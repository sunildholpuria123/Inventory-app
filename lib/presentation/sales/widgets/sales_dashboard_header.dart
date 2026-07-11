import 'package:flutter/material.dart';

import '../screens/sales_analytics_screen.dart';

class SalesDashboardHeader extends StatelessWidget {
  const SalesDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sales',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage invoices and sales history',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalesAnalyticsScreen()),
              );
            },
            icon: const Icon(Icons.analytics),
            label: const Text('Analytics'),
          ),
        ],
      ),
    );
  }
}
