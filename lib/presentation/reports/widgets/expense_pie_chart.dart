import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class ExpensePieChart extends ConsumerWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseAnalyticsProvider);

    return expenses.when(
      loading: () => _buildLoadingCard(),

      error: (e, _) => _buildErrorCard(e.toString()),

      data: (data) {
        if (data.isEmpty) {
          return _buildEmptyCard();
        }

        final entries = data.entries.toList();

        final total = entries.fold<double>(0, (sum, e) => sum + e.value);

        final colors = [
          Colors.blue,
          Colors.orange,
          Colors.green,
          Colors.red,
          Colors.purple,
          Colors.teal,
          Colors.indigo,
          Colors.brown,
        ];

        final isMobile = MediaQuery.of(context).size.width < 700;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expense Distribution",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                Text(
                  "Expenses by category",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 24),

                if (isMobile)
                  Column(
                    children: [
                      _buildChart(entries, colors, total),
                      const SizedBox(height: 24),
                      _buildLegend(entries, colors, total),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildChart(entries, colors, total),
                      ),

                      const SizedBox(width: 30),

                      Expanded(
                        flex: 2,
                        child: _buildLegend(entries, colors, total),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(
    List<MapEntry<String, double>> entries,
    List<Color> colors,
    double total,
  ) {
    return SizedBox(
      height: 280,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 60,
          sectionsSpace: 3,
          borderData: FlBorderData(show: false),
          sections: List.generate(entries.length, (index) {
            final item = entries[index];

            final percentage = total == 0 ? 0 : (item.value / total) * 100;

            return PieChartSectionData(
              color: colors[index % colors.length],
              value: item.value,
              radius: 72,
              title: "${percentage.toStringAsFixed(0)}%",
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLegend(
    List<MapEntry<String, double>> entries,
    List<Color> colors,
    double total,
  ) {
    return Column(
      children: entries.asMap().entries.map((entry) {
        final index = entry.key;

        final item = entry.value;

        final percentage = total == 0 ? 0 : (item.value / total) * 100;

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(child: Text(item.key, overflow: TextOverflow.ellipsis)),

              Text(
                "₹${item.value.toStringAsFixed(0)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: 45,
                child: Text(
                  "${percentage.toStringAsFixed(0)}%",
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoadingCard() {
    return const Card(
      child: SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyCard() {
    return const Card(
      child: SizedBox(
        height: 320,
        child: Center(child: Text("No expense data available")),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      child: SizedBox(height: 320, child: Center(child: Text(error))),
    );
  }
}
