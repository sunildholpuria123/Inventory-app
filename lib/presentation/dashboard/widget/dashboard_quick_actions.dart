import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_provider.dart';

class DashboardQuickActions extends ConsumerWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    final actions = [
      _QuickAction(
        Icons.point_of_sale,
        'New Sale',
        3, // Sales
      ),

      _QuickAction(
        Icons.shopping_bag,
        'Purchase',
        4, // Purchase
      ),

      _QuickAction(Icons.person_add_alt_1, 'Customers', 2),

      _QuickAction(Icons.inventory_2, 'Products', 1),

      _QuickAction(Icons.local_shipping, 'Suppliers', 9),

      _QuickAction(Icons.bar_chart, 'Reports', 7),

      _QuickAction(Icons.settings, 'Settings', 8),

      _QuickAction(Icons.analytics, 'Analytics', 11),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isMobile ? 2 : 4;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 1.25 : 1.35,
          ),
          itemBuilder: (_, index) {
            final action = actions[index];

            return _DashboardActionCard(
              action: action,
              onTap: () {
                ref.read(selectedMenuProvider.notifier).state =
                    action.pageIndex;
              },
            );
          },
        );
      },
    );
  }
}

class _DashboardActionCard extends StatelessWidget {
  final _QuickAction action;
  final VoidCallback onTap;

  const _DashboardActionCard({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(action.icon, color: colorScheme.primary, size: 30),
              ),

              const SizedBox(height: 14),

              Text(
                action.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String title;
  final int pageIndex;

  const _QuickAction(this.icon, this.title, this.pageIndex);
}
