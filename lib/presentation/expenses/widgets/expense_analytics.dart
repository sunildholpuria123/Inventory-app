import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseAnalytics
    extends StatelessWidget {
  const ExpenseAnalytics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,

      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding:
                const EdgeInsets.all(
                  20,
                ),

                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        title: 'Food',
                      ),

                      PieChartSectionData(
                        value: 30,
                        title:
                        'Transport',
                      ),

                      PieChartSectionData(
                        value: 20,
                        title:
                        'Office',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Card(
              child: Padding(
                padding:
                const EdgeInsets.all(
                  20,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: const [
                    Text(
                      'Monthly Expenses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Total Expenses',
                    ),

                    SizedBox(height: 10),

                    Text(
                      '₹25,000',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}