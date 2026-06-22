import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/reminder_scheduler.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../analytics/screens/analytics_dashboard_screen.dart';
import '../../analytics/widgets/ai_price_recommendation_card.dart';
import '../../analytics/widgets/demand_prediction_card.dart';
import '../../analytics/widgets/purchase_forecast_card.dart';
import '../../analytics/widgets/reorder_suggestion_card.dart';
import '../../analytics/widgets/supplier_score_card.dart';
import '../widget/dashboard_kpi_grid.dart';
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
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),

                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.analytics,
                        ),
                        tooltip: 'Analytics',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const AnalyticsDashboardScreen(),
                            ),
                          );
                        },
                      ),

                      const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// KPI
              const DashboardKpiGrid(),

              const SizedBox(height: 20),

              /// DUE ALERTS
              // const DuePaymentAlertWidget(),

              const SizedBox(height: 20),

              if (isMobile) ...[
                const SizedBox(height: 250, child: SalesOverviewChart()),

                const SizedBox(height: 20),


                const SizedBox(height: 250, child: RecentSalesWidget()),

                const SizedBox(height: 20),

                const VariantSalesWidget(),

                const SizedBox(height: 20),

                const VariantInventoryWidget(),

                const SizedBox(height: 20),

                const SupplierPurchaseWidget(),

                const SizedBox(height: 20),

                const PayablesWidget(),

                const SizedBox(height: 20),

                const PurchaseReturnDashboardSection(),

                const SizedBox(height: 20),

                const SizedBox(height: 250, child: LowStockWidget()),
                const PurchaseForecastCard(),
                const SizedBox(height: 20),
                const DemandPredictionCard(),

                const PurchaseForecastCard(),
                const SizedBox(height: 20),

                const DemandPredictionCard(),
                const SizedBox(height: 20),

                const SupplierScoreCard(),
                const SizedBox(height: 20),

                const AiPriceRecommendationCard(),
                const SizedBox(height: 20),

                const ReorderSuggestionCard(),

              ] else
                ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Expanded(
                        flex: 2,

                        child: SizedBox(
                            height: 400, child: SalesOverviewChart()),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: const [
                              SizedBox(height: 250, child: RecentSalesWidget()),

                              SizedBox(height: 20),

                              VariantSalesWidget(),

                              SizedBox(height: 20),

                              SupplierPurchaseWidget(),

                              SizedBox(height: 20),

                              PayablesWidget(),

                              SizedBox(height: 20),

                              PurchaseReturnDashboardSection(),

                              SizedBox(height: 20),

                              SizedBox(height: 250, child: LowStockWidget()),
                            ],
                          ),
                        ),
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
