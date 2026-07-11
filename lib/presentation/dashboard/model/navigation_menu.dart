import 'package:flutter/material.dart';

class NavigationMenu {
  final int index;
  final String title;
  final IconData icon;
  final bool showInBottomBar;
  final bool showInSidebar;

  const NavigationMenu({
    required this.index,
    required this.title,
    required this.icon,
    this.showInBottomBar = false,
    this.showInSidebar = true,
  });
}

class NavigationMenus {
  static const dashboard = NavigationMenu(
    index: 0,
    title: 'Dashboard',
    icon: Icons.dashboard,
    showInBottomBar: true,
  );

  static const products = NavigationMenu(
    index: 1,
    title: 'Products',
    icon: Icons.inventory_2,
    showInBottomBar: true,
  );

  static const customers = NavigationMenu(
    index: 2,
    title: 'Customers',
    icon: Icons.people,
  );

  static const sales = NavigationMenu(
    index: 3,
    title: 'Sales',
    icon: Icons.shopping_cart,
    showInBottomBar: true,
  );

  static const purchases = NavigationMenu(
    index: 4,
    title: 'Purchases',
    icon: Icons.shopping_bag,
    showInBottomBar: true,
  );
  static const more = NavigationMenu(
    index: 5,
    title: 'More',
    icon: Icons.more_horiz,
    showInBottomBar: true,
  );

  static const expenses = NavigationMenu(
    index: 6,
    title: 'Expenses',
    icon: Icons.payments,
  );

  static const reports = NavigationMenu(
    index: 7,
    title: 'Reports',
    icon: Icons.bar_chart,
  );

  static const settings = NavigationMenu(
    index: 8,
    title: 'Settings',
    icon: Icons.settings,
  );

  static const suppliers = NavigationMenu(
    index: 9,
    title: 'Suppliers',
    icon: Icons.local_shipping,
  );

  static const backup = NavigationMenu(
    index: 10,
    title: 'Backup',
    icon: Icons.backup,
  );

  static const analytics = NavigationMenu(
    index: 11,
    title: 'Analytics',
    icon: Icons.analytics,
  );

  static const purchaseAi = NavigationMenu(
    index: 12,
    title: 'Purchase AI',
    icon: Icons.smart_toy,
  );

  static const all = [
    dashboard,
    products,
    customers,
    sales,
    purchases,
    more,
    expenses,
    reports,
    settings,
    suppliers,
    backup,
    analytics,
    purchaseAi,
  ];

  static final bottomMenus = all.where((e) => e.showInBottomBar).toList();

  static final sidebarMenus = all.where((e) => e.showInSidebar).toList();
}
