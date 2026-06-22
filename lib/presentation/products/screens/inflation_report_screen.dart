import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_price_analytics_provider.dart';

class InflationReportScreen extends ConsumerWidget {
  const InflationReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(inflationReportProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inflation Report')),
      body: report.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Data'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(
                  '${item.oldPurchasePrice.toStringAsFixed(2)} → ${item.newPurchasePrice.toStringAsFixed(2)}',
                ),
                subtitle: Text(item.remarks ?? ''),
                trailing: Text(
                  '${item.inflationPercentage.toStringAsFixed(2)}%',
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
