import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../../data/database/app_database.dart';
import '../auth/repository/auth_repository.dart';
import '../dashboard/provider/dashboard_provider.dart';


class AppSidebar
    extends ConsumerWidget {
  const AppSidebar({
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

    return Container(
      width: 260,
      color: const Color(
        0xff111827,
      ),

      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 40),

            const Icon(
              Icons.inventory_2,
              size: 70,
              color: Colors.white,
            ),

            const SizedBox(height: 15),

            const Text(
              'Inventory ERP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            buildItem(
              ref,
              icon: Icons.dashboard,
              title: 'Dashboard',
              index: 0,
              selected: selected,
            ),

            buildItem(
              ref,
              icon:
              Icons.inventory_2,
              title: 'Products',
              index: 1,
              selected: selected,
            ),

            buildItem(
              ref,
              icon: Icons.people,
              title: 'Customers',
              index: 2,
              selected: selected,
            ),

            buildItem(
              ref,
              icon:
              Icons.receipt_long,
              title: 'Sales',
              index: 3,
              selected: selected,
            ),

            buildItem(
              ref,
              icon:
              Icons.shopping_cart,
              title: 'Purchases',
              index: 4,
              selected: selected,
            ),

            buildItem(
              ref,
              icon:
              Icons.money_off,
              title: 'Expenses',
              index: 5,
              selected: selected,
            ),

            buildItem(
              ref,
              icon: Icons.bar_chart,
              title: 'Reports',
              index: 6,
              selected: selected,
            ),

            buildItem(
              ref,
              icon: Icons.settings,
              title: 'Settings',
              index: 7,
              selected: selected,
            ),
            buildItem(
              ref,
              icon: Icons.local_shipping,
              title: 'Suppliers',
              index: 8,
              selected: selected,
            ),
            buildItem(
              ref,
              icon: Icons.backup,
              title: 'Backup',
              index: 9,
              selected: selected,
            ),
            const Spacer(),
            buildItem(
              ref,
              icon: Icons.logout,
              title: 'Logout',
              index: -1,
              selected: selected,
              onTap: () async {
                final repo = AuthRepository(
                  AppDatabase(),
                );

                await repo.logout();

                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                        (route) => false,
                  );
                }
              },
            ),
            buildItem(
              ref,
              icon: Icons.close,
              title: 'Exit',
              index: -2,
              selected: selected,
              onTap: () async {
                await windowManager.close();
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget buildItem(
      WidgetRef ref, {
        required IconData icon,
        required String title,
        required int index,
        required int selected,
        VoidCallback? onTap,
      }) {
    final isSelected =
        selected == index;

    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),
        ),

        tileColor:
        isSelected
            ? Colors.indigo
            : Colors.transparent,

        leading: Icon(
          icon,
          color: Colors.white,
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

        onTap:
        onTap ??
                () {
              ref
                  .read(
                selectedMenuProvider
                    .notifier,
              )
                  .state = index;
            },
      ),
    );
  }
}