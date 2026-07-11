import 'package:flutter/material.dart';

import 'customer_kpi_card.dart';


class CustomerDashboardCards extends StatelessWidget {
  final int totalCustomers;

  const CustomerDashboardCards({super.key, required this.totalCustomers});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 700;

    final cards = [
      CustomerKpiCard(
        title: 'Customers',
        value: '$totalCustomers',
        icon: Icons.people,
        color: Colors.blue,
      ),
      const CustomerKpiCard(
        title: 'Due Payments',
        value: 'View',
        icon: Icons.payments,
        color: Colors.orange,
      ),
      const CustomerKpiCard(
        title: 'Ledger',
        value: 'Manage',
        icon: Icons.receipt_long,
        color: Colors.green,
      ),
    ];

    if (mobile) {
      return SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, index) => SizedBox(width: 240, child: cards[index]),
        ),
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: cards.map((e) => SizedBox(width: 260, child: e)).toList(),
    );
  }
}
