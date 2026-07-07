import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InventoryBarChart extends StatelessWidget {
  const InventoryBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real inventory analytics provider
    final inventory = [
      _InventoryData('Low', 12),
      _InventoryData('Medium', 28),
      _InventoryData('High', 8),
    ];

    final maxValue = inventory
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory Overview',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              Text(
                'Stock level distribution',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxValue * 1.2,

                    borderData: FlBorderData(show: false),

                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: (maxValue * 1.2) / 5,
                    ),

                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),

                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= inventory.length) {
                              return const SizedBox();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                inventory[value.toInt()].label,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.toInt()} Products',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),

                    barGroups: List.generate(inventory.length, (index) {
                      final item = inventory[index];

                      Color color;

                      switch (index) {
                        case 0:
                          color = Colors.red;
                          break;
                        case 1:
                          color = Colors.orange;
                          break;
                        default:
                          color = Colors.green;
                      }

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: item.value,
                            width: 28,
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  _Legend(color: Colors.red, label: 'Low Stock'),
                  _Legend(color: Colors.orange, label: 'Medium Stock'),
                  _Legend(color: Colors.green, label: 'Healthy Stock'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InventoryData {
  final String label;
  final double value;

  const _InventoryData(this.label, this.value);
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
