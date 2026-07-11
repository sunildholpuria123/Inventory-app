import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';
import 'customer_loyalty_card.dart';

class CustomerProfileOverviewTab extends StatelessWidget {
  final Customer customer;

  const CustomerProfileOverviewTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        CustomerLoyaltyCard(customer: customer),

        const SizedBox(height: 20),

        Card(
          child: ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone'),
            subtitle: Text(customer.phone),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(customer.email ?? 'Not Available'),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Address'),
            subtitle: Text(customer.address ?? 'Not Available'),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Credit Balance'),
            trailing: Text(
              '₹${customer.creditBalance.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Customer Since'),
            subtitle: Text(customer.createdAt.toString().substring(0, 10)),
          ),
        ),
      ],
    );
  }
}
