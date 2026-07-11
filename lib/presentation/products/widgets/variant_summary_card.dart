import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

class VariantSummaryCard extends StatelessWidget {
  final List<ProductVariant> variants;

  const VariantSummaryCard({super.key, required this.variants});

  @override
  Widget build(BuildContext context) {
    final totalStock = variants.fold(0.0, (sum, item) => sum + item.stockQty);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Column(
              children: [
                const Text('Variants'),

                Text(variants.length.toString()),
              ],
            ),

            Column(
              children: [
                const Text('Stock'),

                Text(totalStock.toStringAsFixed(0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
