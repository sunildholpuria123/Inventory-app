import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../customers/screen/customer_list_screen.dart';
import '../../expenses/screens/expense_screen.dart';
import '../../products/screens/product_list_screen.dart';
import '../../purchases/screens/purchase_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../sales/screens/create_invoice_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../suppliers/screens/supplier_screen.dart';
import '../../widgets/app_sidebar.dart';

import '../provider/dashboard_provider.dart';
import 'dashboard_home.dart';

class DashboardScreen
    extends ConsumerWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final selected = ref.watch(
      selectedMenuProvider,
    );

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const AppSidebar(),

            Expanded(
              child: IndexedStack(
                index: selected,

                children: const [
                  DashboardHome(),
                  ProductListScreen(),
                  CustomerListScreen(),
                  CreateInvoiceScreen(),
                  PurchaseScreen(),
                  ExpenseScreen(),
                  ReportsScreen(),
                  SettingsScreen(),
                  SupplierScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}