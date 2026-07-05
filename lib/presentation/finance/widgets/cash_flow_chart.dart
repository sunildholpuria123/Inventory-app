import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CashFlowChart
    extends StatelessWidget {
  final double cashIn;
  final double cashOut;

  const CashFlowChart({
    super.key,
    required this.cashIn,
    required this.cashOut,
  });

  @override
  Widget build(
      BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),
        child: SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: cashIn,
                  title:
                  'In',
                ),
                PieChartSectionData(
                  value: cashOut,
                  title:
                  'Out',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}