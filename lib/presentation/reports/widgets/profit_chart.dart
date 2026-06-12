import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProfitChart extends StatelessWidget {
  const ProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Profit Distribution',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 40, title: 'Sales'),

                    PieChartSectionData(value: 30, title: 'Expenses'),

                    PieChartSectionData(value: 30, title: 'Profit'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
