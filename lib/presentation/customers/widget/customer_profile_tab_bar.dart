import 'package:flutter/material.dart';

class CustomerProfileTabBar
    extends StatelessWidget {
  final TabController controller;

  const CustomerProfileTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Material(
      color:
      Theme.of(context)
          .cardColor,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabs: const [
          Tab(
            icon:
            Icon(Icons.dashboard),
            text: 'Overview',
          ),
          Tab(
            icon: Icon(
              Icons.receipt_long,
            ),
            text: 'Invoices',
          ),
          Tab(
            icon:
            Icon(Icons.payments),
            text: 'Payments',
          ),
          Tab(
            icon: Icon(Icons.note),
            text: 'Notes',
          ),
          Tab(
            icon:
            Icon(Icons.folder),
            text: 'Documents',
          ),
        ],
      ),
    );
  }
}