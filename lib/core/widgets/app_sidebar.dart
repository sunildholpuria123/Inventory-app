import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/dashboard/constants/dashboard_pages.dart';
import '../../presentation/dashboard/model/navigation_menu.dart';
import '../../presentation/dashboard/provider/dashboard_provider.dart';

class AppSidebar extends ConsumerWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected =
    ref.watch(selectedMenuProvider);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color:
        Theme.of(context)
            .colorScheme
            .surface,
        border: Border(
          right: BorderSide(
            color:
            Theme.of(context)
                .dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),

          ListTile(
            leading: CircleAvatar(
              backgroundColor:
              Theme.of(context)
                  .colorScheme
                  .primary,
              child: const Icon(
                Icons.inventory_2,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Inventory ERP',
              style:
              Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),
            subtitle:
            const Text(
              'Business Management',
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              itemCount:
              NavigationMenus
                  .sidebarMenus
                  .length,
              itemBuilder:
                  (context, index) {
                final menu =
                NavigationMenus
                    .sidebarMenus[
                index];

                return _item(
                  context,
                  ref,
                  menu,
                );
              },
            ),
          ),        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      WidgetRef ref,
      NavigationMenu menu,
      ) {
    final selected =
        ref.watch(
          selectedMenuProvider,
        ) ==
            menu.index;

    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Material(
        color: selected
            ? Theme.of(context)
            .colorScheme
            .primaryContainer
            : Colors.transparent,
        borderRadius:
        BorderRadius.circular(
          14,
        ),
        child: ListTile(
          leading: Icon(
            menu.icon,
            color: selected
                ? Theme.of(context)
                .colorScheme
                .primary
                : null,
          ),
          title: Text(
            menu.title,
            style: TextStyle(
              fontWeight: selected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              14,
            ),
          ),
          onTap: () {
            ref
                .read(
              selectedMenuProvider
                  .notifier,
            )
                .state =
                menu.index;
          },
        ),
      ),
    );
  }
}