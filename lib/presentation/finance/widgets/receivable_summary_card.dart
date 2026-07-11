import 'package:flutter/material.dart';

class ReceivableSummaryCard extends StatelessWidget {
  final double amount;

  const ReceivableSummaryCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.payments)),
        title: const Text('Total Receivables'),
        trailing: Text(
          '₹${amount.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
    );
  }
}
