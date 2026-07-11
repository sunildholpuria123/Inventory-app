import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/profit_analytics_provider.dart';

class ProfitAnalyticsWidget
    extends ConsumerWidget {
  const ProfitAnalyticsWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final profit =
    ref.watch(
      profitAnalyticsProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          16,
        ),
        child: profit.when(
          data: (data) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'Profit Analytics',
                  style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(
                  height: 20,
                ),

                ListTile(
                  title:
                  const Text(
                    'Revenue',
                  ),
                  trailing:
                  Text(
                    '₹${data.revenue.toStringAsFixed(0)}',
                  ),
                ),

                ListTile(
                  title:
                  const Text(
                    'Estimated Profit',
                  ),
                  trailing:
                  Text(
                    '₹${data.estimatedProfit.toStringAsFixed(0)}',
                  ),
                ),
              ],
            );
          },
          loading:
              () =>
          const CircularProgressIndicator(),
          error:
              (e, _) =>
              Text(
                e.toString(),
              ),
        ),
      ),
    );
  }
}