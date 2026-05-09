import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesChart
    extends StatelessWidget {
  const SalesChart({
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
              'Sales Analytics',
              style: TextStyle(
                fontSize: 20,
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
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 2),
                        FlSpot(3, 5),
                        FlSpot(4, 4),
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