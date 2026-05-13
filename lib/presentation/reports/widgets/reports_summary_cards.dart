import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart' show profitProvider, inventoryValueProvider;


class ReportsSummaryCards
    extends ConsumerWidget {
  const ReportsSummaryCards({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final profit =
    ref.watch(
      profitProvider,
    );

    final inventory =
    ref.watch(
      inventoryValueProvider,
    );

    return Row(
      children: [
        Expanded(
          child: buildCard(
            'Profit',

            profit.when(
              data: (value) =>
              '₹${value.toStringAsFixed(0)}',

              loading: () =>
              '...',

              error: (_, __) =>
              '0',
            ),

            Icons.trending_up,
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        Expanded(
          child: buildCard(
            'Inventory Value',

            inventory.when(
              data: (value) =>
              '₹${value.toStringAsFixed(0)}',

              loading: () =>
              '...',

              error: (_, __) =>
              '0',
            ),

            Icons.inventory,
          ),
        ),
      ],
    );
  }

  Widget buildCard(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,

              child: Icon(icon),
            ),

            const SizedBox(
              width: 20,
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Text(title),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  value,

                  style:
                  const TextStyle(
                    fontSize: 24,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}