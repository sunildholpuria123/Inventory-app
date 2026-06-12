import 'package:flutter/material.dart';

import 'create_invoice_screen.dart';
import 'sales_history_screen.dart';

class SalesHomeScreen extends StatefulWidget {
  const SalesHomeScreen({super.key});

  @override
  State<SalesHomeScreen> createState() => _SalesHomeScreenState();
}

class _SalesHomeScreenState extends State<SalesHomeScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,

            child: TabBar(
              controller: controller,

              tabs: const [
                Tab(text: 'Sales History'),

                Tab(text: 'Create Invoice'),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: controller,

              children: const [SalesHistoryScreen(), CreateInvoiceScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
