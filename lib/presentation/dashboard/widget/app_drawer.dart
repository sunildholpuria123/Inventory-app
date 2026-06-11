import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/provider/navigation_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedIndexProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              color: const Color(0xFF111827),
              child: const Column(
                children: [
                  Icon(
                    Icons.inventory_2,
                    size: 70,
                    color: Colors.white,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Inventory ERP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                children: [
                  buildItem(
                    context,
                    ref,
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.inventory_2,
                    title: 'Products',
                    index: 1,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.people,
                    title: 'Customers',
                    index: 2,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.receipt_long,
                    title: 'Sales',
                    index: 3,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.shopping_cart,
                    title: 'Purchases',
                    index: 4,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.money_off,
                    title: 'Expenses',
                    index: 5,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.bar_chart,
                    title: 'Reports',
                    index: 6,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.local_shipping,
                    title: 'Suppliers',
                    index: 7,
                    selected: selected,
                  ),

                  buildItem(
                    context,
                    ref,
                    icon: Icons.settings,
                    title: 'Settings',
                    index: 8,
                    selected: selected,
                  ),
                ],
              ),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);

                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      'Logout',
                    ),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            false,
                          );
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),

                      FilledButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            true,
                          );
                        },
                        child: const Text(
                          'Logout',
                        ),
                      ),
                    ],
                  ),
                );

                if (shouldLogout != true) {
                  return;
                }

                /// TODO:
                /// FirebaseAuth.instance.signOut();

                /// TODO:
                /// Navigator.pushReplacement(...)
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: const Text(
                'Exit App',
              ),
              onTap: () async {
                Navigator.pop(context);

                final shouldExit = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      'Exit Application',
                    ),
                    content: const Text(
                      'Do you want to close the application?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            false,
                          );
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),

                      FilledButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            true,
                          );
                        },
                        child: const Text(
                          'Exit',
                        ),
                      ),
                    ],
                  ),
                );

                if (shouldExit != true) {
                  return;
                }

                if (!Platform.isAndroid &&
                    !Platform.isIOS) {
                  exit(0);
                }
              },
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context,
      WidgetRef ref, {
        required IconData icon,
        required String title,
        required int index,
        required int selected,
      }) {
    final isSelected = selected == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Theme.of(context)
              .colorScheme
              .primary
              : null,
        ),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        selected: isSelected,

        selectedTileColor: Theme.of(context)
            .colorScheme
            .primaryContainer,

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),

        onTap: () {
          ref
              .read(
            selectedIndexProvider
                .notifier,
          )
              .state = index;

          Navigator.pop(context);
        },
      ),
    );
  }
}