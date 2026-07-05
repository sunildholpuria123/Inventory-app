import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/profit_loss_provider.dart';
import '../widgets/profit_loss_summary_card.dart';

class ProfitLossScreen extends ConsumerWidget {
  const ProfitLossScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(profitLossProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profit & Loss')),
      body: data.when(
        data: (pl) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ProfitLossSummaryCard(
                  title: 'Revenue',
                  amount: pl.revenue,
                  color: Colors.green,
                ),

                ProfitLossSummaryCard(
                  title: 'Purchases',
                  amount: pl.purchases,
                  color: Colors.orange,
                ),

                ProfitLossSummaryCard(
                  title: 'Expenses',
                  amount: pl.expenses,
                  color: Colors.red,
                ),

                ProfitLossSummaryCard(
                  title: 'Gross Profit',
                  amount: pl.grossProfit,
                  color: Colors.blue,
                ),

                ProfitLossSummaryCard(
                  title: 'Net Profit',
                  amount: pl.netProfit,
                  color: pl.netProfit >= 0 ? Colors.green : Colors.red,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
