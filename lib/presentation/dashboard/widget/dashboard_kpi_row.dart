import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reports/provider/report_provider.dart' hide totalSalesProvider;
import '../provider/dashboard_provider.dart';

class DashboardKpiRow extends ConsumerWidget {
  const DashboardKpiRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenue = ref.watch(revenueProvider);

    final totalProducts = ref.watch(totalProductsProvider);

    final totalCustomers = ref.watch(totalCustomersProvider);

    final totalSales = ref.watch(totalSalesProvider);

    return Row(
      children: [
        /// REVENUE
        Expanded(
          child: revenue.when(
            data: (value) {
              return DashboardKpiCard(
                title: 'Revenue',

                value: '₹${value.toStringAsFixed(2)}',

                icon: Icons.currency_rupee,
              );
            },

            loading: () => const DashboardLoadingCard(),

            error: (e, _) => DashboardErrorCard(error: e.toString()),
          ),
        ),

        const SizedBox(width: 20),

        /// PRODUCTS
        Expanded(
          child: totalProducts.when(
            data: (value) {
              return DashboardKpiCard(
                title: 'Products',

                value: value.toString(),

                icon: Icons.inventory_2,
              );
            },

            loading: () => const DashboardLoadingCard(),

            error: (e, _) => DashboardErrorCard(error: e.toString()),
          ),
        ),

        const SizedBox(width: 20),

        /// CUSTOMERS
        Expanded(
          child: totalCustomers.when(
            data: (value) {
              return DashboardKpiCard(
                title: 'Customers',

                value: value.toString(),

                icon: Icons.people,
              );
            },

            loading: () => const DashboardLoadingCard(),

            error: (e, _) => DashboardErrorCard(error: e.toString()),
          ),
        ),

        const SizedBox(width: 20),

        /// SALES
        Expanded(
          child: totalSales.when(
            data: (value) {
              return DashboardKpiCard(
                title: 'Orders',

                value: value.toString(),

                icon: Icons.shopping_cart,
              );
            },

            loading: () => const DashboardLoadingCard(),

            error: (e, _) => DashboardErrorCard(error: e.toString()),
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
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,

              backgroundColor: Colors.indigo.withOpacity(0.1),

              child: Icon(icon, color: Colors.indigo),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(title, style: TextStyle(color: Colors.grey[700])),

                  const SizedBox(height: 5),

                  Text(
                    value,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 24,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardLoadingCard extends StatelessWidget {
  const DashboardLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        height: 110,

        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class DashboardErrorCard extends StatelessWidget {
  final String error;

  const DashboardErrorCard({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 110,

        child: Center(
          child: Text(
            error,

            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
