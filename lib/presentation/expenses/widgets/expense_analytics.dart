import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/expense_provider.dart';

class ExpenseAnalytics extends ConsumerWidget {
  const ExpenseAnalytics({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final expenses =
    ref.watch(expensesProvider);

    return expenses.when(
      data: (items) {
        final categoryTotals =
        <String, double>{};

        double totalExpense = 0;

        for (final expense in items) {
          totalExpense += expense.amount;

          categoryTotals.update(
            expense.category,
                (value) =>
            value + expense.amount,
            ifAbsent: () =>
            expense.amount,
          );
        }

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
                        sections:
                        categoryTotals.entries
                            .map(
                              (e) =>
                              PieChartSectionData(
                                value:
                                e.value,
                                title:
                                e.key,
                              ),
                        )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: 20,
              ),

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

                      children: [
                        const Text(
                          'Monthly Expenses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          'Total Expenses',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          '₹${totalExpense.toStringAsFixed(0)}',
                          style:
                          const TextStyle(
                            fontSize: 32,
                            fontWeight:
                            FontWeight
                                .bold,
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
      },

      loading: () =>
      const Center(
        child:
        CircularProgressIndicator(),
      ),

      error: (e, _) =>
          Center(
            child: Text(
              e.toString(),
            ),
          ),
    );
  }
}