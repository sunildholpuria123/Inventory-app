import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_provider.dart';

class ProductDashboardCards extends ConsumerWidget {
  const ProductDashboardCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    final isMobile = MediaQuery.of(context).size.width < 700;

    return products.when(
      data: (items) {
        final totalProducts = items.length;

        final lowStock = items.where((e) => e.stockQty <= e.minStock).length;

        final inventoryValue = items.fold<double>(
          0,
          (sum, e) => sum + (e.stockQty * e.purchasePrice),
        );

        final cards = [
          _card(
            context,
            'Products',
            totalProducts.toString(),
            Icons.inventory_2,
            Colors.blue,
          ),
          _card(
            context,
            'Low Stock',
            lowStock.toString(),
            Icons.warning,
            Colors.red,
          ),
          _card(
            context,
            'Inventory Value',
            '₹${inventoryValue.toStringAsFixed(0)}',
            Icons.account_balance_wallet,
            Colors.green,
          ),
        ];

        if (isMobile) {
          return SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) =>
                  SizedBox(width: 180, child: cards[index]),
            ),
          );
        }

        return Wrap(spacing: 16, runSpacing: 16, children: cards);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text(e.toString()),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < 600 ? double.infinity : 250.0;

        return SizedBox(
          width: width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(icon, size: 40, color: color),
                  const SizedBox(height: 12),
                  Text(value, style: Theme.of(context).textTheme.headlineSmall),
                  Text(title),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
