import 'package:flutter/material.dart';
import 'package:inventory_desktop/presentation/analytics/screens/purchase_ai_dashboard_screen.dart';

import '../../analytics/screens/analytics_dashboard_screen.dart';
import '../../categories/screen/category_management_screen.dart';
import '../../customers/screen/due_payments_screen.dart';
import '../../expenses/screens/expense_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../settings/screens/backup_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../suppliers/screens/supplier_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),

      body: ListView(
        children: [
          _item(
            context,
            Icons.category,
            'Categories',
            const CategoryManagementScreen(),
          ),

          _item(context, Icons.business, 'Suppliers', const SupplierScreen()),

          _item(context, Icons.money_off, 'Expenses', const ExpenseScreen()),

          _item(context, Icons.analytics, 'Reports', const ReportsScreen()),
          _item(context, Icons.sync_problem_sharp, 'Purchase AI', const PurchaseAiDashboardScreen()),
          _item(context, Icons.report, 'Analytics', const AnalyticsDashboardScreen()),

          _item(
            context,
            Icons.notifications,
            'Due Payments',
            const DuePaymentsScreen(),
          ),

          _item(
            context,
            Icons.backup,
            'Backup & Restore',
            const BackupScreen(),
          ),

          _item(context, Icons.settings, 'Settings', const SettingsScreen()),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    Widget screen,
  ) {
    return ListTile(
      leading: Icon(icon),

      title: Text(title),

      trailing: const Icon(Icons.chevron_right),

      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }
}
