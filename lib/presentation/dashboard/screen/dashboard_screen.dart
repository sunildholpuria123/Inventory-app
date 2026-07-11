import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_sidebar.dart';
import '../constants/dashboard_pages.dart';
import '../provider/dashboard_provider.dart';
import '../widget/app_drawer.dart';
import '../../../core/widgets/app_bottom_nav.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    final isMobile = ResponsiveHelper.isMobile(context);

    final selected = isDesktop
        ? ref.watch(selectedMenuProvider)
        : ref.watch(selectedMenuProvider);

    /// DESKTOP
    if (isDesktop) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              const AppSidebar(),

              Expanded(child: dashboardPages[selected]),
            ],
          ),
        ),
      );
    }

    /// MOBILE / TABLET
    return Scaffold(
      drawer: const AppDrawer(),

      body: SafeArea(child: dashboardPages[selected]),

      bottomNavigationBar: isMobile ? const AppBottomNav() : null,
    );
  }
}
