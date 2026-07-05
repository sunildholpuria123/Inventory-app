import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/cash_flow_provider.dart';
import '../widgets/cash_flow_chart.dart';
import '../widgets/cash_flow_summary.dart';
import '../widgets/recent_transactions_widget.dart';

class CashFlowScreen extends ConsumerWidget {
  const CashFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashFlowProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cash Flow')),
      body: cash.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CashFlowSummary(data: data),

                const SizedBox(height: 20),

                CashFlowChart(cashIn: data.cashIn, cashOut: data.cashOut),
                const SizedBox(height: 20),

                const RecentTransactionsWidget(),
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
