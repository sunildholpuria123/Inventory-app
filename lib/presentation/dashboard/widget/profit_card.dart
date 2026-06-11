import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_stats_provider.dart';

class ProfitCard extends ConsumerWidget {
  const ProfitCard({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final summary = ref.watch(
      profitSummaryProvider,
    );

    return summary.when(
      data: (data) {

        final isProfit =
            data.profit >= 0;

        return Card(
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

                Text(
                  isProfit
                      ? 'Net Profit'
                      : 'Net Loss',

                  style:
                  const TextStyle(
                    fontSize: 18,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  '₹${data.profit.toStringAsFixed(0)}',

                  style: TextStyle(
                    fontSize: 36,

                    fontWeight:
                    FontWeight
                        .bold,

                    color: isProfit
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

                const Divider(),

                buildRow(
                  'Revenue',
                  data.revenue,
                ),

                buildRow(
                  'Purchases',
                  data.purchases,
                ),

                buildRow(
                  'Expenses',
                  data.expenses,
                ),
              ],
            ),
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

  Widget buildRow(
      String title,
      double value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 4,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [

          Text(title),

          Text(
            '₹${value.toStringAsFixed(0)}',
          ),
        ],
      ),
    );
  }
}