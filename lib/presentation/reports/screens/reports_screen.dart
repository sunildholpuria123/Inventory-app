import 'package:flutter/material.dart';

import '../../../core/widgets/report_export_buttons.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/inventory_bar_chart.dart';
import '../widgets/monthly_report_sales_chart.dart';
import '../widgets/profit_chart.dart';
import '../widgets/report_date_filter_widget.dart';
import '../widgets/reports_summary_cards.dart';
import '../widgets/top_products_widget.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Business Reports',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Analyze sales, profit, expenses and inventory performance.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              /// Date Filter
              const ReportDateFilterWidget(),

              const SizedBox(height: 24),

              /// Summary
              const ReportsSummaryCards(),

              const SizedBox(height: 24),

              /// Monthly Sales
              _buildSectionTitle(context, 'Monthly Sales', Icons.show_chart),

              const SizedBox(height: 12),

              const MonthlyReportSalesChart(),

              const SizedBox(height: 24),

              /// Profit Analysis
              _buildSectionTitle(context, 'Profit Analysis', Icons.trending_up),

              const SizedBox(height: 12),

              const ProfitChart(),

              const SizedBox(height: 24),

              /// Expense Distribution
              _buildSectionTitle(
                context,
                'Expense Distribution',
                Icons.pie_chart,
              ),

              const SizedBox(height: 12),

              const ExpensePieChart(),

              const SizedBox(height: 24),

              /// Inventory
              _buildSectionTitle(
                context,
                'Inventory Status',
                Icons.inventory_2,
              ),

              const SizedBox(height: 12),

              const InventoryBarChart(),

              const SizedBox(height: 24),

              /// Top Products
              _buildSectionTitle(context, 'Top Selling Products', Icons.star),

              const SizedBox(height: 12),

              const TopProductsWidget(),

              const SizedBox(height: 28),

              /// Export
              _buildSectionTitle(context, 'Export Reports', Icons.download),

              const SizedBox(height: 12),

              const ReportExportButtons(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
