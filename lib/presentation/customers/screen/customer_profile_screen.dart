import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../widget/customer_documents_tab.dart';
import '../widget/customer_invoices_tab.dart';
import '../widget/customer_notes_tab.dart';
import '../widget/customer_payments_tab.dart';
import '../widget/customer_profile_header.dart';
import '../widget/customer_profile_overview_tab.dart';
import '../widget/customer_profile_tab_bar.dart';
import '../widget/customer_profile_actions.dart';
import '../screen/customer_ledger_screen.dart';
import '../widget/edit_customer_dialog.dart';
import '../../../core/utils/whatsapp_helper.dart';

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
            CustomerProfileActions(
              onReceivePayment: () {
                controller.animateTo(1); // Invoices Tab
              },
              onLedger: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CustomerLedgerScreen(customer: widget.customer),
                  ),
                );
              },
              onWhatsapp: () async {
                await WhatsAppHelper.openChat(
                  phone: widget.customer.phone,
                  message: 'Hello ${widget.customer.name}',
                );
              },
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (_) => EditCustomerDialog(customer: widget.customer),
                );
              },
            ),

            CustomerProfileTabBar(controller: controller),

            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  CustomerProfileOverviewTab(customer: widget.customer),

                  CustomerInvoicesTab(customer: widget.customer),

                  CustomerPaymentsTab(customer: widget.customer),

                  CustomerNotesTab(customer: widget.customer),

                  CustomerDocumentsTab(customer: widget.customer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
