import 'package:flutter/material.dart';

import '../model/transaction_timeline_item.dart';

class TransactionTimelineTile extends StatelessWidget {
  final TransactionTimelineItem item;

  const TransactionTimelineTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isIncome =
        item.type == TransactionType.sale ||
        item.type == TransactionType.customerPayment;

    final color = isIncome ? Colors.green : Colors.red;

    final icon = switch (item.type) {
      TransactionType.sale => Icons.shopping_cart,

      TransactionType.purchase => Icons.inventory,

      TransactionType.expense => Icons.money_off,

      TransactionType.customerPayment => Icons.payments,

      TransactionType.supplierPayment => Icons.account_balance,
    };

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(item.title),
        subtitle: Text(item.date.toString().substring(0, 16)),
        trailing: Text(
          '${isIncome ? '+' : '-'}₹${item.amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
