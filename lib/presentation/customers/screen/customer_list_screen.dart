import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/core/utils/responsive_helper.dart';

import '../../sales/widgets/top_customers_widget.dart';
import '../provider/customer_dashboard_provider.dart';
import '../provider/customer_provider.dart';
import '../widget/add_customer_dialog.dart';
import '../widget/customer_card_list.dart';
import '../widget/customer_credit_dashboard.dart';
import '../widget/customer_dashboard_cards.dart';
import '../widget/customer_dashboard_header.dart';
import '../widget/customer_insights_widget.dart';
import '../widget/customer_quick_actions.dart';
import '../widget/customer_table.dart';
import '../widget/customer_timeline_widget.dart';
import '../widget/recent_payments_widget.dart';

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersProvider);

    final dashboard = ref.watch(customerDashboardProvider);

    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const AddCustomerDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Customer'),
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const CustomerDashboardHeader(),
                const SizedBox(height: 20),

                dashboard.when(
                  data: (data) {
                    return CustomerDashboardCards(
                      totalCustomers: data.totalCustomers,
                    );
                  },
                  loading: () => const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, _) => Text(e.toString()),
                ),

                const SizedBox(height: 20),

                const CustomerInsightsWidget(),

                const SizedBox(height: 20),

                const CustomerQuickActions(),

                const SizedBox(height: 20),

                const RecentPaymentsWidget(),

                const SizedBox(height: 20),

                const CustomerCreditDashboard(),

                const SizedBox(height: 20),

                const TopCustomersWidget(),

                const SizedBox(height: 20),

                const CustomerTimelineWidget(),

                const SizedBox(height: 32),

                Text(
                  'Customers',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Customer...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onChanged: (value) {
                        ref.read(customerSearchProvider.notifier).state = value;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ]),
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: true,
            child: customers.when(
              data: (items) {
                final search = ref.watch(customerSearchProvider);

                final filtered = items.where((customer) {
                  return customer.name.toLowerCase().contains(
                    search.toLowerCase(),
                  );
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No Customers Found'));
                }

                return isMobile
                    ? CustomerCardList(customers: filtered)
                    : CustomerTable(customers: filtered);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
