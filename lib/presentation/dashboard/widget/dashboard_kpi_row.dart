import 'package:flutter/material.dart';

class DashboardKpiRow
    extends StatelessWidget {
  const DashboardKpiRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DashboardKpiCard(
            title: 'Revenue',
            value: '₹1,50,000',
            icon: Icons.currency_rupee,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: DashboardKpiCard(
            title: 'Products',
            value: '150',
            icon: Icons.inventory_2,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: DashboardKpiCard(
            title: 'Customers',
            value: '80',
            icon: Icons.people,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: DashboardKpiCard(
            title: 'Orders',
            value: '45',
            icon: Icons.shopping_cart,
          ),
        ),
      ],
    );
  }
}

class DashboardKpiCard
    extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  const DashboardKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: Icon(icon),
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Text(title),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}