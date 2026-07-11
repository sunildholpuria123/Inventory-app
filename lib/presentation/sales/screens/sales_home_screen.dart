import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sales_dashboard_provider.dart';
import '../widgets/sales_dashboard_cards.dart';
import '../widgets/sales_dashboard_header.dart';
import '../widgets/sales_tabBar_delegate.dart';
import 'create_invoice_screen.dart';
import 'sales_history_screen.dart';

class SalesHomeScreen extends StatefulWidget {
  const SalesHomeScreen({super.key});

  @override
  State<SalesHomeScreen> createState() =>
      _SalesHomeScreenState();
}

class _SalesHomeScreenState
    extends State<SalesHomeScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SalesDashboardHeader(),

                  Consumer(
                    builder:
                        (context, ref, _) {
                      final dashboard =
                      ref.watch(
                        salesDashboardProvider,
                      );

                      return dashboard.when(
                        data: (data) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child:
                            SalesDashboardCards(
                              totalSales:
                              data.totalSales,
                              totalDue:
                              data.totalDue,
                              totalInvoices:
                              data.totalInvoices,
                            ),
                          );
                        },
                        loading:
                            () =>
                        const Padding(
                          padding:
                          EdgeInsets.all(
                            20,
                          ),
                          child:
                          CircularProgressIndicator(),
                        ),
                        error:
                            (e, _) =>
                            Padding(
                              padding:
                              const EdgeInsets.all(
                                20,
                              ),
                              child:
                              Text(
                                e.toString(),
                              ),
                            ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate:
              SalesTabBarDelegate(
                TabBar(
                  controller:
                  controller,
                  indicatorSize:
                  TabBarIndicatorSize
                      .tab,
                  dividerColor:
                  Colors.transparent,
                  tabs: const [
                    Tab(
                      icon:
                      Icon(
                        Icons
                            .history,
                      ),
                      text:
                      'History',
                    ),
                    Tab(
                      icon:
                      Icon(
                        Icons
                            .receipt_long,
                      ),
                      text:
                      'Invoice',
                    ),
                  ],
                ),
              ),
            ),
          ];
        },

        body: TabBarView(
          controller: controller,
          children: const [
            SalesHistoryScreen(),
            CreateInvoiceScreen(),
          ],
        ),
      ),
    );
  }
}