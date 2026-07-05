import 'package:flutter/material.dart';

import '../model/finance_dashboard_data.dart';
import 'finance_kpi_card.dart';

class FinanceSummaryGrid extends StatelessWidget {
  final FinanceDashboardData data;

  const FinanceSummaryGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width < 700 ? 2 : 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1,
      children: [
        FinanceKpiCard(
          title: 'Revenue',
          value: '₹${data.revenue.toStringAsFixed(0)}',
          icon: Icons.trending_up,
          color: Colors.green,
        ),

        FinanceKpiCard(
          title: 'Expenses',
          value: '₹${data.expenses.toStringAsFixed(0)}',
          icon: Icons.money_off,
          color: Colors.red,
        ),

        FinanceKpiCard(
          title: 'Profit',
          value: '₹${data.profit.toStringAsFixed(0)}',
          icon: Icons.account_balance_wallet,
          color: Colors.blue,
        ),

        FinanceKpiCard(
          title: 'Receivables',
          value: '₹${data.receivables.toStringAsFixed(0)}',
          icon: Icons.payments,
          color: Colors.orange,
        ),

        FinanceKpiCard(
          title: 'Payables',
          value: '₹${data.payables.toStringAsFixed(0)}',
          icon: Icons.receipt_long,
          color: Colors.purple,
        ),
      ],
    );
  }
}
