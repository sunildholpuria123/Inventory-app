import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: StatCard(title: 'Revenue', value: '₹50,000'),
        ),

        SizedBox(width: 20),

        Expanded(
          child: StatCard(title: 'Products', value: '150'),
        ),

        SizedBox(width: 20),

        Expanded(
          child: StatCard(title: 'Customers', value: '80'),
        ),

        SizedBox(width: 20),

        Expanded(
          child: StatCard(title: 'Orders', value: '35'),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
