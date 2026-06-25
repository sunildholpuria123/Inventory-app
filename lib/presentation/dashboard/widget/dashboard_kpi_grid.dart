import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';
import 'DashboardKpiCardV2.dart';

class DashboardKpiGrid extends ConsumerWidget {
  const DashboardKpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenue = ref.watch(revenueProvider);

    final products = ref.watch(totalProductsProvider);

    final customers = ref.watch(totalCustomersProvider);

    final sales = ref.watch(totalSalesProvider);

    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    double ratio = 0.95;

    if (width >= 1400) {
      crossAxisCount = 4;
      ratio = 1.45;
    } else if (width >= 900) {
      crossAxisCount = 3;
      ratio = 1.35;
    } else if (width >= 700) {
      crossAxisCount = 2;
      ratio = 1.20;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: ratio,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return DashboardKpiCardV2(
              title: 'Revenue',
              value: revenue.when(
                data: (v) => v,
                loading: () => 0,
                error: (_, __) => 0,
              ),
              icon: Icons.currency_rupee,
              color: Colors.green,
              subtitle: 'Total Revenue',
            ).animate().fadeIn().slideY(begin: .20, duration: 500.ms);

          case 1:
            return DashboardKpiCardV2(
                  title: 'Products',
                  value: products.when(
                    data: (v) => v.toDouble(),
                    loading: () => 0,
                    error: (_, __) => 0,
                  ),
                  icon: Icons.inventory_2,
                  color: Colors.blue,
                  subtitle: 'Total Products',
                  showCurrency: false,
                )
                .animate()
                .fadeIn(delay: 100.ms)
                .slideY(begin: .20, duration: 500.ms);

          case 2:
            return DashboardKpiCardV2(
                  title: 'Customers',
                  value: customers.when(
                    data: (v) => v.toDouble(),
                    loading: () => 0,
                    error: (_, __) => 0,
                  ),
                  icon: Icons.people,
                  color: Colors.orange,
                  subtitle: 'Total Customers',
                  showCurrency: false,
                )
                .animate()
                .fadeIn(delay: 200.ms)
                .slideY(begin: .20, duration: 500.ms);

          default:
            return DashboardKpiCardV2(
                  title: 'Sales',
                  value: sales.when(
                    data: (v) => v.toDouble(),
                    loading: () => 0,
                    error: (_, __) => 0,
                  ),
                  icon: Icons.shopping_cart,
                  color: Colors.purple,
                  subtitle: 'Total Orders',
                  showCurrency: false,
                )
                .animate()
                .fadeIn(delay: 300.ms)
                .slideY(begin: .20, duration: 500.ms);
        }
      },
    );
  }
}
