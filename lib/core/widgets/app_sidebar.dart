import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/dashboard/constants/dashboard_pages.dart';
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
            child: ListView(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              children: [_item(
                context,
                ref,
                0,
                Icons.dashboard_outlined,
                'Dashboard',
              ),

                _item(
                  context,
                  ref,
                  1,
                  Icons.inventory_2_outlined,
                  'Products',
                ),

                _item(
                  context,
                  ref,
                  2,
                  Icons.people_outline,
                  'Customers',
                ),

                _item(
                  context,
                  ref,
                  9,
                  Icons.local_shipping_outlined,
                  'Suppliers',
                ),

                _item(
                  context,
                  ref,
                  5,
                  Icons.shopping_bag_outlined,
                  'Purchases',
                ),

                _item(
                  context,
                  ref,
                  7,
                  Icons.analytics_outlined,
                  'Analytics',
                ),

                _item(
                  context,
                  ref,
                  4,
                  Icons.psychology_outlined,
                  'Purchase AI',
                ),

                _item(
                  context,
                  ref,
                  8,
                  Icons.settings_outlined,
                  'Settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      WidgetRef ref,
      int index,
      IconData icon,
      String title,
      ) {
    final selected =
        ref.watch(
          selectedMenuProvider,
        ) ==
            index;

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
            icon,
            color: selected
                ? Theme.of(context)
                .colorScheme
                .primary
                : null,
          ),
          title: Text(
            title,
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
            print(
              'Sidebar clicked: $index',
            );
            ref
                .read(
              selectedMenuProvider
                  .notifier,
            )
                .state = index;
          },
        ),
      ),
    );
  }
}