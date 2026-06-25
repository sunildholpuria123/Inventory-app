import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/reminder_scheduler.dart';
import '../../../core/utils/responsive_helper.dart';
import '../widget/dash_board_grid.dart';
import '../widget/dashboard_header.dart';
import '../widget/dashboard_kpi_grid.dart';
import '../widget/dashboard_quick_actions.dart';
import '../widget/due_payment_alert_widget.dart';
import '../widget/low_stock_widget.dart';
import '../widget/payables_widget.dart';
import '../widget/profit_card.dart';
import '../widget/purchase_return_dashboard_section.dart';
import '../widget/recent_sales_widget.dart';
import '../widget/sales_overview_chart.dart';
import '../widget/supplier_purchase_widget.dart';
import '../widget/variant_inventory_widget.dart';
import '../widget/variant_sales_widget.dart';

class DashboardHome extends ConsumerStatefulWidget {
  const DashboardHome({super.key});

  @override
  ConsumerState<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends ConsumerState<DashboardHome> {
  bool _checkedReminders = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_checkedReminders) {
      _checkedReminders = true;

      Future.microtask(() => ReminderScheduler.checkReminders(ref));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// HEADER
              const DashboardHeader(),
              const SizedBox(height: 20),
              const DashboardQuickActions(),

              const SizedBox(height: 24),

              /// KPI
              const DashboardKpiGrid(),

              const SizedBox(height: 20),

              /// DUE ALERTS
              // const DuePaymentAlertWidget(),

              const SizedBox(height: 20),

              if (isMobile) ...[
                const SizedBox(
                  height: 260,
                  child: SalesOverviewChart(),
                ),

                const SizedBox(height: 20),

                const DuePaymentAlertWidget(),

                const SizedBox(height: 20),

                const SizedBox(
                  height: 250,
                  child: RecentSalesWidget(),
                ),

                const SizedBox(height: 20),

                const VariantInventoryWidget(),

                const SizedBox(height: 20),

                const SizedBox(
                  height: 250,
                  child: LowStockWidget(),
                ),
              ] else
                ...[
                  Column(
                    children: [
                      SizedBox(
                        height: 450,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: SalesOverviewChart(),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: Column(
                                children: const [
                                  Expanded(
                                    child: RecentSalesWidget(),
                                  ),

                                  SizedBox(height: 20),

                                  Expanded(
                                    child: DuePaymentAlertWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const VariantSalesWidget(),

                      const SizedBox(height: 20),

                      const SupplierPurchaseWidget(),

                      const SizedBox(height: 20),

                      const PayablesWidget(),

                      const SizedBox(height: 20),

                      const PurchaseReturnDashboardSection(),

                      const SizedBox(height: 20),

                      const VariantInventoryWidget(),

                      const SizedBox(height: 20),

                      const SizedBox(
                        height: 300,
                        child: LowStockWidget(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // const VariantInventoryWidget(),
                ],

              const SizedBox(height: 20),

              // const ProfitCard(),
            ],
          ),
        ),
      ),
    );
  }
}
