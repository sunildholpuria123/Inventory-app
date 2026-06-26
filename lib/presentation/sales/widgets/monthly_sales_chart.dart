import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_analytics_provider.dart';

class MonthlySalesChart extends ConsumerWidget {
  const MonthlySalesChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(monthlySalesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: sales.when(
          data: (items) {
            if (items.isEmpty) {
              return const SizedBox(
                height: 250,
                child: Center(child: Text('No sales data')),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Sales',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: true),

                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();

                              if (index >= items.length) {
                                return const SizedBox();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(items[index].month.substring(5)),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(items.length, (index) {
                        final item = items[index];

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: item.amount,
                              width: 24,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) =>
              SizedBox(height: 250, child: Center(child: Text(e.toString()))),
        ),
      ),
    );
  }
}
