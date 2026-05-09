import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InventoryBarChart
    extends StatelessWidget {
  const InventoryBarChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),

        child: BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(
                x: 0,

                barRods: [
                  BarChartRodData(
                    toY: 10,
                  ),
                ],
              ),

              BarChartGroupData(
                x: 1,

                barRods: [
                  BarChartRodData(
                    toY: 7,
                  ),
                ],
              ),

              BarChartGroupData(
                x: 2,

                barRods: [
                  BarChartRodData(
                    toY: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}