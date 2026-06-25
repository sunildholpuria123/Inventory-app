import 'package:flutter/material.dart';

import 'sales_analytics_card.dart';

class SalesDashboardCards extends StatelessWidget {
  final double totalSales;
  final double totalDue;
  final int totalInvoices;

  const SalesDashboardCards({
    super.key,
    required this.totalSales,
    required this.totalDue,
    required this.totalInvoices,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 700;

    final cards = [
      SalesAnalyticsCard(
        title: 'Total Sales',
        value: '₹${totalSales.toStringAsFixed(0)}',
        icon: Icons.payments,
        color: Colors.green,
      ),
      SalesAnalyticsCard(
        title: 'Due Amount',
        value: '₹${totalDue.toStringAsFixed(0)}',
        icon: Icons.warning,
        color: Colors.orange,
      ),
      SalesAnalyticsCard(
        title: 'Invoices',
        value: totalInvoices.toString(),
        icon: Icons.receipt_long,
        color: Colors.blue,
      ),
    ];

    if (mobile) {
      return SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, index) => SizedBox(width: 220, child: cards[index]),
        ),
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: cards.map((e) => SizedBox(width: 250, child: e)).toList(),
    );
  }
}
