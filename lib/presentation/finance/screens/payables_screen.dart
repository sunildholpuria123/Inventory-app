import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/payables_provider.dart';
import '../widgets/payable_summary_card.dart';
import '../widgets/payable_tile.dart';

class PayablesScreen extends ConsumerWidget {
  const PayablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payables = ref.watch(payablesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payables')),
      body: payables.when(
        data: (items) {
          final total = items.fold(0.0, (sum, e) => sum + e.amount);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: PayableSummaryCard(amount: total),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return PayableTile(item: items[index]);
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
