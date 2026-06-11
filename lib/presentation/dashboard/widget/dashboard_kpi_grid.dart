import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';
import 'dashboard_error_card.dart' show DashboardErrorCard;
import 'dashboard_kpi_row.dart' show DashboardKpiCard;
import 'dashboard_loading_card.dart' show DashboardLoadingCard;

class DashboardKpiGrid extends ConsumerWidget {
  const DashboardKpiGrid({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final revenue =
    ref.watch(revenueProvider);

    final products =
    ref.watch(totalProductsProvider);

    final customers =
    ref.watch(totalCustomersProvider);

    final sales =
    ref.watch(totalSalesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {

        int crossAxisCount;

        if (constraints.maxWidth >= 1100) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 700) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.count(
          crossAxisCount:
          crossAxisCount,

          shrinkWrap: true,

          physics:
          const NeverScrollableScrollPhysics(),

          crossAxisSpacing: 20,

          mainAxisSpacing: 20,

          childAspectRatio:
          constraints.maxWidth < 700
              ? 3.5
              : 2.5,

          children: [

            revenue.when(
              data: (value) =>
                  DashboardKpiCard(
                    title: 'Revenue',
                    value:
                    '₹${value.toStringAsFixed(0)}',
                    icon:
                    Icons.currency_rupee,
                  ),

              loading: () =>
              const DashboardLoadingCard(),

              error: (_, __) =>
              const DashboardErrorCard(),
            ),

            products.when(
              data: (value) =>
                  DashboardKpiCard(
                    title: 'Products',
                    value:
                    value.toString(),
                    icon:
                    Icons.inventory_2,
                  ),

              loading: () =>
              const DashboardLoadingCard(),

              error: (_, __) =>
              const DashboardErrorCard(),
            ),

            customers.when(
              data: (value) =>
                  DashboardKpiCard(
                    title: 'Customers',
                    value:
                    value.toString(),
                    icon:
                    Icons.people,
                  ),

              loading: () =>
              const DashboardLoadingCard(),

              error: (_, __) =>
              const DashboardErrorCard(),
            ),

            sales.when(
              data: (value) =>
                  DashboardKpiCard(
                    title: 'Orders',
                    value:
                    value.toString(),
                    icon:
                    Icons.shopping_cart,
                  ),

              loading: () =>
              const DashboardLoadingCard(),

              error: (_, __) =>
              const DashboardErrorCard(),
            ),
          ],
        );
      },
    );
  }
}