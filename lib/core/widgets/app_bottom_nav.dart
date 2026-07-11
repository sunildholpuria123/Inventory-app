import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/dashboard/model/navigation_menu.dart';
import '../../presentation/dashboard/provider/dashboard_provider.dart';

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final selected =
    ref.watch(
      selectedMenuProvider,
    );

    final menus =
        NavigationMenus.bottomMenus;

    final selectedIndex =
    menus.indexWhere(
          (e) =>
      e.index ==
          selected,
    );

    return NavigationBar(
      selectedIndex:
      selectedIndex < 0
          ? 0
          : selectedIndex,
      onDestinationSelected:
          (index) {
        ref
            .read(
          selectedMenuProvider
              .notifier,
        )
            .state =
            menus[index].index;
      },
      destinations:
      menus
          .map(
            (e) =>
            NavigationDestination(
              icon:
              Icon(
                e.icon,
              ),
              label:
              e.title,
            ),
      )
          .toList(),
    );
  }
}