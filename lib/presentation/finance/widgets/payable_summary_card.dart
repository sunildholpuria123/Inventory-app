import 'package:flutter/material.dart';

class PayableSummaryCard extends StatelessWidget {
  final double amount;

  const PayableSummaryCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.account_balance)),
        title: const Text('Total Payables'),
        trailing: Text(
          '₹${amount.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
