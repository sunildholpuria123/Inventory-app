import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final Map<String, double> data;

  const ExpensePieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: data.entries.map((e) {
          return PieChartSectionData(value: e.value, title: e.key);
        }).toList(),
      ),
    );
  }
}
