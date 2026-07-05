import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/finance_dashboard_provider.dart';
import '../widgets/finance_quick_actions.dart';
import '../widgets/finance_summary_grid.dart';
import '../widgets/recent_transactions_widget.dart';
import '../widgets/revenue_expense_chart.dart';

class FinanceHomeScreen extends ConsumerWidget {
  const FinanceHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(financeDashboardProvider);

    return Scaffold(
      body: dashboard.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finance',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 20),

                FinanceSummaryGrid(data: data),

                const SizedBox(height: 30),

                RevenueExpenseChart(
                  revenue: data.revenue,
                  expenses: data.expenses,
                ),

                const SizedBox(height: 20),

                const RecentTransactionsWidget(),
                const SizedBox(height: 30),

                const FinanceQuickActions(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
