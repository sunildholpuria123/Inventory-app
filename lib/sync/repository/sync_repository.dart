import 'package:flutter/material.dart';

import '../../data/database/app_database.dart';
import '../mapper/customer_sync_mapper.dart';
import '../mapper/expense_sync_mapper.dart';
import '../mapper/invoice_item_sync_mapper.dart';
import '../mapper/invoice_sync_mapper.dart';
import '../mapper/payment_sync_mapper.dart';
import '../mapper/product_sync_mapper.dart';
import '../mapper/supplier_sync_mapper.dart';
import '../model/sync_packet.dart';
import '../model/sync_statistics.dart';
import '../model/sync_table.dart';

class SyncRepository {
  final AppDatabase db;
  final supplierMapper = SupplierSyncMapper();
  final invoiceMapper = InvoiceSyncMapper();
  final invoiceItemMapper = InvoiceItemSyncMapper();
  final paymentSyncMapper = PaymentSyncMapper();
  final expenseSyncMapper = ExpenseSyncMapper();
  final productSyncMapper = ProductSyncMapper();

  SyncRepository(this.db);

  Future<SyncPacket> exportData({
    required String deviceId,
    required String deviceName,
    required List<SyncTable> tables,
  }) async {
    final payload = <String, dynamic>{};

    if (tables.contains(SyncTable.customers)) {
      final customers = await db.select(db.customers).get();

      payload['customers'] = customers.map(CustomerSyncMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.suppliers)) {
      final suppliers = await db.select(db.suppliers).get();

      payload['suppliers'] = suppliers.map(supplierMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.products)) {
      final products = await db.select(db.products).get();

      payload['products'] = products.map(productSyncMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.invoices)) {
      final invoices = await db.select(db.invoices).get();
      payload['invoices'] = invoices.map(invoiceMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.invoiceItems)) {
      final items = await db.select(db.invoiceItems).get();

      payload['invoiceItems'] = items.map(invoiceItemMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.payments)) {
      final payments = await db.select(db.paymentHistories).get();

      payload['payments'] = payments.map(paymentSyncMapper.toMap).toList();
    }

    if (tables.contains(SyncTable.expenses)) {
      final expenses = await db.select(db.expenses).get();

      payload['expenses'] = expenses.map(expenseSyncMapper.toMap).toList();
    }

    return SyncPacket(
      deviceId: deviceId,
      deviceName: deviceName,
      createdAt: DateTime.now(),
      payload: payload,
    );
  }

  Future<void> importData(SyncPacket packet) async {
    debugPrint("[REPOSITORY] importData() called");
    print("========== SYNC PACKET RECEIVED ==========");
    print("Device ID   : ${packet.deviceId}");
    print("Device Name : ${packet.deviceName}");
    print("Created At  : ${packet.createdAt}");
    print("Payload     : ${packet.payload}");
    print("=========================================");
    print("Customers     : ${(packet.payload['customers'] as List?)?.length ?? 0}");
    print("Suppliers     : ${(packet.payload['suppliers'] as List?)?.length ?? 0}");
    print("Products      : ${(packet.payload['products'] as List?)?.length ?? 0}");
    print("Invoices      : ${(packet.payload['invoices'] as List?)?.length ?? 0}");
    print("InvoiceItems  : ${(packet.payload['invoiceItems'] as List?)?.length ?? 0}");
    print("Payments      : ${(packet.payload['payments'] as List?)?.length ?? 0}");
    print("Expenses      : ${(packet.payload['expenses'] as List?)?.length ?? 0}");
    await db.transaction(() async {
      /// Customers
      final customers = (packet.payload['customers'] as List?) ?? [];

      for (final json in customers) {
        await db
            .into(db.customers)
            .insertOnConflictUpdate(
              CustomerSyncMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Suppliers
      final suppliers = (packet.payload['suppliers'] as List?) ?? [];

      for (final json in suppliers) {
        await db
            .into(db.suppliers)
            .insertOnConflictUpdate(
              supplierMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Products
      final products = (packet.payload['products'] as List?) ?? [];

      for (final json in products) {
        await db
            .into(db.products)
            .insertOnConflictUpdate(
              productSyncMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Invoices
      final invoices = (packet.payload['invoices'] as List?) ?? [];

      for (final json in invoices) {
        await db
            .into(db.invoices)
            .insertOnConflictUpdate(
              invoiceMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Invoice Items
      final invoiceItems = (packet.payload['invoiceItems'] as List?) ?? [];

      for (final json in invoiceItems) {
        await db
            .into(db.invoiceItems)
            .insertOnConflictUpdate(
              invoiceItemMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Payments
      final payments = (packet.payload['payments'] as List?) ?? [];

      for (final json in payments) {
        await db
            .into(db.paymentHistories)
            .insertOnConflictUpdate(
              paymentSyncMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }

      /// Expenses
      final expenses = (packet.payload['expenses'] as List?) ?? [];

      for (final json in expenses) {
        await db
            .into(db.expenses)
            .insertOnConflictUpdate(
              expenseSyncMapper.toCompanion(Map<String, dynamic>.from(json)),
            );
      }
    });
  }

  Future<SyncStatistics> getStatistics() async {
    final customers = await db.select(db.customers).get();

    final suppliers = await db.select(db.suppliers).get();

    final products = await db.select(db.products).get();

    final invoices = await db.select(db.invoices).get();

    final invoiceItems = await db.select(db.invoiceItems).get();

    final payments = await db.select(db.paymentHistories).get();

    final expenses = await db.select(db.expenses).get();

    return SyncStatistics(
      customers: customers.length,
      suppliers: suppliers.length,
      products: products.length,
      invoices: invoices.length,
      invoiceItems: invoiceItems.length,
      payments: payments.length,
      expenses: expenses.length,
    );
  }
}
