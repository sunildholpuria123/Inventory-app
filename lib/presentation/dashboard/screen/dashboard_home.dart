import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart' show ResponsiveHelper;
import '../widget/dashboard_kpi_grid.dart' show DashboardKpiGrid;
import '../widget/low_stock_widget.dart';
import '../widget/profit_card.dart' show ProfitCard;
import '../widget/recent_sales_widget.dart';
import '../widget/sales_overview_chart.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Dashboard',

                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const CircleAvatar(radius: 24, child: Icon(Icons.person)),
                ],
              ),

              const SizedBox(height: 20),

              const DashboardKpiGrid(),

              const SizedBox(height: 20),

              isMobile
                  ? const Column(
                      children: [
                        SizedBox(height: 250, child: SalesOverviewChart()),

                        SizedBox(height: 20),

                        SizedBox(height: 250, child: RecentSalesWidget()),

                        SizedBox(height: 20),

                        SizedBox(height: 250, child: LowStockWidget()),
                      ],
                    )
                  : SizedBox(
                      height: 500,

                      child: Row(
                        children: [
                          const Expanded(flex: 2, child: SalesOverviewChart()),

                          const SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              children: const [
                                Expanded(child: RecentSalesWidget()),

                                SizedBox(height: 20),

                                Expanded(child: LowStockWidget()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 20),

              const ProfitCard(),
            ],
          ),
        ),
      ),
    );
  }
}
