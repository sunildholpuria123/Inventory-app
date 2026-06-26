import 'package:inventory_desktop/presentation/analytics/screens/analytics_dashboard_screen.dart';
import 'package:inventory_desktop/presentation/analytics/screens/purchase_ai_dashboard_screen.dart';
import 'package:inventory_desktop/presentation/dashboard/screen/more_screen.dart';

import '../../customers/screen/customer_list_screen.dart';
import '../../expenses/screens/expense_screen.dart' show ExpenseScreen;
import '../../products/screens/product_list_screen.dart';
import '../../purchases/screens/purchase_screen.dart';
import '../../reports/screens/reports_screen.dart' show ReportsScreen;
import '../../sales/screens/sales_home_screen.dart';
import '../../settings/screens/backup_screen.dart' show BackupScreen;
import '../../settings/screens/settings_screen.dart' show SettingsScreen;
import '../../suppliers/screens/supplier_screen.dart' show SupplierScreen;
import '../screen/dashboard_home.dart';

final dashboardPages = [
  DashboardHome(),
  ProductListScreen(),
  CustomerListScreen(),
  SalesHomeScreen(),
  PurchaseScreen(),
  MoreScreen(),
  ExpenseScreen(),
  ReportsScreen(),
  SettingsScreen(),
  SupplierScreen(),
  BackupScreen(),
  AnalyticsDashboardScreen(),
  PurchaseAiDashboardScreen()
];
