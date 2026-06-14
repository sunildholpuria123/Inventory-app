import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class DashboardKpiRow extends ConsumerWidget {
  const DashboardKpiRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenue = ref.watch(revenueProvider);

    final products = ref.watch(totalProductsProvider);

    final customers = ref.watch(totalCustomersProvider);

    final sales = ref.watch(totalSalesProvider);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(
          width: 280,
          child: DashboardKpiCard(
            title: 'Revenue',

            value: revenue.when(
              data: (value) => 'Rs.${value.toStringAsFixed(0)}',

              loading: () => '...',

              error: (_, __) => '0',
            ),

            icon: Icons.currency_rupee,
          ),
        ),

        const SizedBox(width: 20),

        SizedBox(
          width: 280,
          child: DashboardKpiCard(
            title: 'Products',

            value: products.when(
              data: (value) => value.toString(),

              loading: () => '...',

              error: (_, __) => '0',
            ),

            icon: Icons.inventory_2,
          ),
        ),

        const SizedBox(width: 20),

        SizedBox(
          width: 280,
          child: DashboardKpiCard(
            title: 'Customers',

            value: customers.when(
              data: (value) => value.toString(),

              loading: () => '...',

              error: (_, __) => '0',
            ),

            icon: Icons.people,
          ),
        ),

        const SizedBox(width: 20),

        SizedBox(
          width: 280,
          child: DashboardKpiCard(
            title: 'Sales',

            value: sales.when(
              data: (value) => value.toString(),

              loading: () => '...',

              error: (_, __) => '0',
            ),

            icon: Icons.shopping_cart,
          ),
        ),
      ],
    );
  }
}

class DashboardKpiCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  const DashboardKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            CircleAvatar(radius: 28, child: Icon(icon)),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 24,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
