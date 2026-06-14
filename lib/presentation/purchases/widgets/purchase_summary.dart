import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_provider.dart';

class PurchaseSummary extends ConsumerWidget {
  const PurchaseSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.watch(purchaseSubtotalProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            const Text('Purchase Total', style: TextStyle(fontSize: 18)),

            Text(
              'Rs.${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
