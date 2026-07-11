import 'package:flutter/material.dart';

import '../model/cash_flow_data.dart';
import 'cash_flow_chart.dart';

class CashFlowSummary extends StatelessWidget {
  final CashFlowData data;

  const CashFlowSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildRow('Cash In', data.cashIn, Colors.green),
            const Divider(),
            buildRow('Cash Out', data.cashOut, Colors.red),
            const Divider(),
            buildRow(
              'Net Cash',
              data.netCash,
              data.netCash >= 0 ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, double amount, Color color) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
