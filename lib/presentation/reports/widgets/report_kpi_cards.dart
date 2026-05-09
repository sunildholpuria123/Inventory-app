import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class ReportKpiCards
    extends ConsumerWidget {
  const ReportKpiCards({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final sales = ref.watch(
      totalSalesProvider,
    );

    final expenses = ref.watch(
      totalExpenseProvider,
    );

    final profit = ref.watch(
      totalProfitProvider,
    );

    return Row(
      children: [
        Expanded(
          child: buildCard(
            'Sales',
            sales,
            Colors.green,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: buildCard(
            'Expenses',
            expenses,
            Colors.red,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: buildCard(
            'Profit',
            profit,
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget buildCard(
      String title,
      double value,
      Color color,
      ) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            Text(title),

            const SizedBox(height: 10),

            Text(
              '₹${value.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}