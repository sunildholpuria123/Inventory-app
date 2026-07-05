import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/receivables_provider.dart';
import '../widgets/receivable_summary_card.dart';
import '../widgets/receivable_tile.dart';

class ReceivablesScreen extends ConsumerWidget {
  const ReceivablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receivables = ref.watch(receivablesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Receivables')),
      body: receivables.when(
        data: (items) {
          final total = items.fold(0.0, (sum, e) => sum + e.amount);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ReceivableSummaryCard(amount: total),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return ReceivableTile(item: items[index]);
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
