import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/ai_sales_recommendation_widget.dart';
import '../widgets/customer_analytics_widget.dart';
import '../widgets/due_payments_widget.dart';
import '../widgets/monthly_sales_chart.dart';
import '../widgets/product_performance_widget.dart';
import '../widgets/profit_analytics_widget.dart';
import '../widgets/sales_forecast_widget.dart';
import '../widgets/top_customers_widget.dart';
import '../widgets/top_selling_products_widget.dart';

class SalesAnalyticsScreen extends ConsumerWidget {
  const SalesAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Analytics')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 900;

          if (mobile) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                MonthlySalesChart(),
                SizedBox(height: 20),
                TopCustomersWidget(),
                SizedBox(height: 20),
                DuePaymentsWidget(),
                SizedBox(height: 20),
                TopSellingProductsWidget(),
                SizedBox(height: 20),
                ProfitAnalyticsWidget(),
                SizedBox(height: 20),
                CustomerAnalyticsWidget(),
                SizedBox(height: 20),

                ProductPerformanceWidget(),
                SizedBox(height: 20),

                SalesForecastWidget(),
                SizedBox(height: 20),

                AiSalesRecommendationWidget(),
                SizedBox(height: 20),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 2, child: MonthlySalesChart()),

                const SizedBox(width: 20),

                const Expanded(
                  child: Column(
                    children: [
                      TopCustomersWidget(),
                      SizedBox(height: 20),
                      DuePaymentsWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
