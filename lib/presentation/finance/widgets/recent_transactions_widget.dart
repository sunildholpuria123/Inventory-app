import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/transaction_timeline_provider.dart';
import '../screens/transaction_timeline_screen.dart';

class RecentTransactionsWidget extends ConsumerWidget {
  const RecentTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionTimelineProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: transactions.when(
          data: (items) {
            if (items.isEmpty) {
              return const Text('No Transactions');
            }

            final latest = items.take(5).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                ...latest.map((e) {
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.title),
                    subtitle: Text(e.date.toString().substring(0, 16)),
                    trailing: Text('₹${e.amount.toStringAsFixed(0)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const TransactionTimelineScreen(),
                        ),
                      );
                    },
                  );
                }),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text(e.toString()),
        ),
      ),
    );
  }
}
