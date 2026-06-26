import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

class CustomerProfileHeader extends StatelessWidget {
  final Customer customer;

  const CustomerProfileHeader({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff7C3AED)],
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Text(
              customer.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  customer.phone,
                  style: const TextStyle(color: Colors.white70),
                ),

                if (customer.email != null)
                  Text(
                    customer.email!,
                    style: const TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          ),

          Chip(label: Text(customer.creditBalance > 0 ? 'Credit' : 'Regular')),
        ],
      ),
    );
  }
}
