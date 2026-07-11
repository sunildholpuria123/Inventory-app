import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/transaction_timeline_provider.dart';
import '../widgets/transaction_timeline_tile.dart';

class TransactionTimelineScreen extends ConsumerWidget {
  const TransactionTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(transactionTimelineProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions Timeline')),
      body: timeline.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Transactions'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (_, index) {
              return TransactionTimelineTile(item: items[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
