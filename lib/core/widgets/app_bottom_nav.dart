import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/dashboard/provider/dashboard_provider.dart';

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedMenuProvider);

    return NavigationBar(
      selectedIndex: selected > 4 ? 0 : selected,

      onDestinationSelected: (index) {
        ref.read(selectedMenuProvider.notifier).state = index;
      },

      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.inventory_2), label: 'Products'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Sales'),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag),
          label: 'Purchase',
        ),
        NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}
