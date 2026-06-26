import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart' show monthlySalesProvider;

class MonthlyReportSalesChart extends ConsumerWidget {
  const MonthlyReportSalesChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(monthlySalesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: SizedBox(
          height: 300,

          child: sales.when(
            data: (items) {
              return BarChart(
                BarChartData(
                  barGroups: items.asMap().entries.map((entry) {
                    final index = entry.key;

                    final item = entry.value;

                    return BarChartGroupData(
                      x: index,

                      barRods: [BarChartRodData(toY: item.total)],
                    );
                  }).toList(),
                ),
              );
            },

            loading: () => const Center(child: CircularProgressIndicator()),

            error: (e, _) => Center(child: Text(e.toString())),
          ),
        ),
      ),
    );
  }
}
