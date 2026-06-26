import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../widget/customer_documents_tab.dart';
import '../widget/customer_loyalty_card.dart';
import '../widget/customer_notes_tab.dart';
import '../widget/customer_profile_header.dart';
import '../widget/customer_profile_overview_tab.dart';
import '../widget/customer_profile_tab_bar.dart';

class CustomerProfileScreen extends ConsumerStatefulWidget {
  final Customer customer;

  const CustomerProfileScreen({super.key, required this.customer});

  @override
  ConsumerState<CustomerProfileScreen> createState() =>
      _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends ConsumerState<CustomerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomerProfileHeader(customer: widget.customer),

            CustomerProfileTabBar(controller: controller),

            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  CustomerProfileOverviewTab(customer: widget.customer),

                  const Center(child: Text('Invoices')),

                  const Center(child: Text('Payments')),

                  CustomerNotesTab(customer: widget.customer),
                  CustomerDocumentsTab(customer: widget.customer),
                  CustomerLoyaltyCard(customer: widget.customer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
