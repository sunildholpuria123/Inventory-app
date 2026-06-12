import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class SalesOverviewChart extends ConsumerWidget {
  const SalesOverviewChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(monthlySalesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Sales Overview',

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: sales.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text('No Sales Data'));
                  }

                  return LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,

                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();

                              if (index >= data.length) {
                                return const SizedBox();
                              }

                              return Text(data[index].month);
                            },
                          ),
                        ),
                      ),

                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,

                          dotData: FlDotData(show: true),

                          spots: data
                              .asMap()
                              .entries
                              .map(
                                (entry) => FlSpot(
                                  entry.key.toDouble(),

                                  entry.value.amount,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },

                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text(e.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
