import 'package:flutter/material.dart';

import '../widget/dashboard_kpi_row.dart';
import '../widget/low_stock_widget.dart';
import '../widget/recent_sales_widget.dart';
import '../widget/sales_overview_chart.dart';



class DashboardHome
    extends StatelessWidget {
  const DashboardHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [
              Text(
                'Dashboard',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              CircleAvatar(
                radius: 24,
                child: Icon(
                  Icons.person,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const DashboardKpiRow(),

          const SizedBox(height: 20),

          Expanded(
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child:
                  SalesOverviewChart(),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        child:
                        RecentSalesWidget(),
                      ),

                      SizedBox(height: 20),

                      Expanded(
                        child:
                        LowStockWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}