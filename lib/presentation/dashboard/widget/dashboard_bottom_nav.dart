import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/navigation_provider.dart';

class DashboardBottomNav
    extends ConsumerWidget {

  const DashboardBottomNav({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final selected =
    ref.watch(
      selectedIndexProvider,
    );

    return NavigationBar(

      selectedIndex:
      selected > 3
          ? 0
          : selected,

      onDestinationSelected:
          (index) {

        ref
            .read(
          selectedIndexProvider
              .notifier,
        )
            .state = index;
      },

      destinations: const [

        NavigationDestination(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.inventory_2,
          ),
          label: 'Products',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.people,
          ),
          label: 'Customers',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.receipt_long,
          ),
          label: 'Sales',
        ),
      ],
    );
  }
}