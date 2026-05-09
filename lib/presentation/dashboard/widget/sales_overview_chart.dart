import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesOverviewChart
    extends StatelessWidget {
  const SalesOverviewChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            const Text(
              'Sales Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,

                      spots: const [
                        FlSpot(0, 2),
                        FlSpot(1, 3),
                        FlSpot(2, 5),
                        FlSpot(3, 4),
                        FlSpot(4, 6),
                      ],
                    ),
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