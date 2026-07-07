import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class ReportsSummaryCards extends ConsumerWidget {
  const ReportsSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profit = ref.watch(profitProvider);
    final inventory = ref.watch(inventoryValueProvider);

    final isMobile = MediaQuery.of(context).size.width < 700;

    final cards = [
      _SummaryCard(
        title: 'Total Profit',
        value: profit.when(
          data: (v) => '₹${v.toStringAsFixed(0)}',
          loading: () => '...',
          error: (_, __) => '--',
        ),
        icon: Icons.trending_up,
        color: Colors.green,
      ),
      _SummaryCard(
        title: 'Inventory Value',
        value: inventory.when(
          data: (v) => '₹${v.toStringAsFixed(0)}',
          loading: () => '...',
          error: (_, __) => '--',
        ),
        icon: Icons.inventory_2,
        color: Colors.blue,
      ),
    ];

    if (isMobile) {
      return Column(children: [cards[0], const SizedBox(height: 16), cards[1]]);
    }

    return Row(
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 20),
        Expanded(child: cards[1]),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: color, size: 30),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
