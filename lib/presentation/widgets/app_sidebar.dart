import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xff1f2937),
      child: Column(
        children: [
          const SizedBox(height: 40),

          const Text(
            'Inventory ERP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          buildItem(Icons.dashboard, 'Dashboard'),
          buildItem(Icons.inventory_2, 'Products'),
          buildItem(Icons.people, 'Customers'),
          buildItem(Icons.receipt_long, 'Sales'),
          buildItem(Icons.shopping_cart, 'Purchases'),
          buildItem(Icons.bar_chart, 'Reports'),
          buildItem(Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget buildItem(
      IconData icon,
      String title,
      ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {},
    );
  }
}