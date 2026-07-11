import 'package:flutter/material.dart';

import 'sync_module.dart';
import 'sync_table.dart';

class SyncModules {
  const SyncModules._();

  static const List<SyncModule> all = [
    SyncModule(
      table: SyncTable.customers,
      key: 'customers',
      title: 'Customers',
      description: 'Customer master records',
      icon: Icons.people_alt_rounded,
      color: Colors.blue,
      order: 1,
    ),

    SyncModule(
      table: SyncTable.suppliers,
      key: 'suppliers',
      title: 'Suppliers',
      description: 'Supplier master records',
      icon: Icons.local_shipping_rounded,
      color: Colors.orange,
      order: 2,
    ),

    SyncModule(
      table: SyncTable.products,
      key: 'products',
      title: 'Products',
      description: 'Products & Inventory',
      icon: Icons.inventory_2_rounded,
      color: Colors.green,
      order: 3,
    ),

    SyncModule(
      table: SyncTable.invoices,
      key: 'invoices',
      title: 'Invoices',
      description: 'Sales invoices',
      icon: Icons.receipt_long_rounded,
      color: Colors.deepPurple,
      order: 4,
    ),

    SyncModule(
      table: SyncTable.invoiceItems,
      key: 'invoiceItems',
      title: 'Invoice Items',
      description: 'Invoice products',
      icon: Icons.shopping_cart_checkout,
      color: Colors.indigo,
      order: 5,
    ),

    SyncModule(
      table: SyncTable.payments,
      key: 'payments',
      title: 'Payments',
      description: 'Payment history',
      icon: Icons.payments_rounded,
      color: Colors.teal,
      order: 6,
    ),

    SyncModule(
      table: SyncTable.expenses,
      key: 'expenses',
      title: 'Expenses',
      description: 'Business expenses',
      icon: Icons.account_balance_wallet_rounded,
      color: Colors.red,
      order: 7,
      defaultSelected: false,
    ),
  ];

  static SyncModule of(SyncTable table) {
    return all.firstWhere(
          (e) => e.table == table,
    );
  }

  static List<SyncModule> get ordered {
    final modules = [...all];

    modules.sort(
          (a, b) => a.order.compareTo(b.order),
    );

    return modules;
  }
}