import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class ProfitChart extends ConsumerWidget {
  const ProfitChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profit = ref.watch(profitProvider);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: profit.when(
          loading: () => const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) =>
              SizedBox(height: 180, child: Center(child: Text(e.toString()))),
          data: (value) {
            final positive = value >= 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Net Profit',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'Current business profitability',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 28),

                Center(
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: positive
                          ? Colors.green.withOpacity(.10)
                          : Colors.red.withOpacity(.10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          positive ? Icons.trending_up : Icons.trending_down,
                          size: 42,
                          color: positive ? Colors.green : Colors.red,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '₹${value.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: positive ? Colors.green : Colors.red,
                              ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          positive ? 'Profit' : 'Loss',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
