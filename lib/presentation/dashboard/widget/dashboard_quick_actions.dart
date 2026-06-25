import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/dashboard_provider.dart';

class DashboardQuickActions extends ConsumerWidget {
  const DashboardQuickActions({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _action(
          context,
          ref,
          Icons.point_of_sale,
          'New Sale',
          3, // Sales Screen
        ),

        _action(
          context,
          ref,
          Icons.shopping_bag,
          'Purchase',
          5, // Purchase Screen
        ),

        _action(
          context,
          ref,
          Icons.person_add,
          'Customer',
          2, // Customer Screen
        ),

        _action(
          context,
          ref,
          Icons.inventory_2,
          'Product',
          1, // Product Screen
        ),
      ],
    );
  }

  Widget _action(
      BuildContext context,
      WidgetRef ref,
      IconData icon,
      String title,
      int pageIndex,
      ) {
    return SizedBox(
      width: 130,
      child: InkWell(
        borderRadius:
        BorderRadius.circular(20),
        onTap: () {
          ref
              .read(
            selectedMenuProvider
                .notifier,
          )
              .state = pageIndex;
        },
        child: Card(
          child: Padding(
            padding:
            const EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 34,
                ),

                const SizedBox(
                  height: 12,
                ),

                Text(
                  title,
                  textAlign:
                  TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}