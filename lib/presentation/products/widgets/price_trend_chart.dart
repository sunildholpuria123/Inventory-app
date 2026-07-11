import 'package:flutter/material.dart';

class PriceTrendChart extends StatelessWidget {
  final List<double> prices;

  const PriceTrendChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    if (prices.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price Trend', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            ...prices.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('₹${e.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
