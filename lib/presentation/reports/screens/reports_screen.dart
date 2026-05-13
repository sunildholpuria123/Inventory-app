import 'package:flutter/material.dart';

import '../../../core/widgets/report_export_buttons.dart' show ReportExportButtons;
import '../widgets/monthly_sales_chart.dart';

import '../widgets/reports_summary_cards.dart';

import '../widgets/top_products_widget.dart';

import '../widgets/report_date_filter_widget.dart';

class ReportsScreen
    extends StatelessWidget {
  const ReportsScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            Text(
              'Reports & Analytics',

              style:
              Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),

            const SizedBox(
              height: 20,
            ),

            /// DATE FILTER
            const ReportDateFilterWidget(),

            const SizedBox(
              height: 20,
            ),

            /// SUMMARY CARDS
            const ReportsSummaryCards(),

            const SizedBox(
              height: 20,
            ),

            /// MONTHLY SALES CHART
            const MonthlySalesChart(),

            const SizedBox(
              height: 20,
            ),

            /// TOP PRODUCTS
            const TopProductsWidget(),
            const SizedBox(
              height: 20,
            ),

            const ReportExportButtons(),
          ],
        ),
      ),
    );
  }
}