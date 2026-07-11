import 'package:flutter/material.dart';
import 'package:inventory_desktop/sync/repository/sync_history_repository.dart';
import 'package:inventory_desktop/sync/service/sync_id_resolver.dart';

import '../../data/database/app_database.dart';
import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';
import '../mapper/business_settings_sync_mapper.dart';
import '../mapper/category_sync_mapper.dart';
import '../mapper/customer_sync_mapper.dart';
import '../mapper/expense_sync_mapper.dart';
import '../mapper/invoice_item_sync_mapper.dart';
import '../mapper/invoice_sync_mapper.dart';
import '../mapper/payment_sync_mapper.dart';
import '../mapper/product_sync_mapper.dart';
import '../mapper/supplier_sync_mapper.dart';
import '../model/sync_packet.dart';
import '../model/database_statistics.dart';
import '../model/sync_statistics.dart';
import '../model/sync_table.dart';
import '../service/conflict_resolver.dart';
import '../utils/sync_value_parser.dart';

class SyncRepository {
  final AppDatabase db;
  final supplierMapper = SupplierSyncMapper();
  final customerMapper = CustomerSyncMapper();
  final invoiceMapper = InvoiceSyncMapper();
  final invoiceItemMapper = InvoiceItemSyncMapper();
  final paymentSyncMapper = PaymentSyncMapper();
  final expenseSyncMapper = ExpenseSyncMapper();
  final productSyncMapper = ProductSyncMapper();
  final categoryMapper = CategorySyncMapper();
  final businessSettingMapper = BusinessSettingsSyncMapper();
  final SyncStatistics _statistics = SyncStatistics();

  SyncStatistics get statistics => _statistics;

  final ConflictResolver resolver;
  final SyncIdResolver syncIdResolver;
  final SyncHistoryRepository historyRepository;

  SyncRepository({
    required this.db,
    required this.resolver,
    required this.syncIdResolver,
    required this.historyRepository,
  });

  Future<SyncPacket> exportData({
    required String deviceId,
    required String deviceName,
    required List<SyncTable> tables,
  }) async {
    final payload = <String, dynamic>{};
    final exportContext = SyncExportContext(db: db);

    if (tables.contains(SyncTable.customers)) {
      final customers = await db.select(db.customers).get();

      payload['customers'] = customers
          .map((e) => customerMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.suppliers)) {
      final suppliers = await db.select(db.suppliers).get();

      payload['suppliers'] = suppliers
          .map((e) => supplierMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.products)) {
      final products = await db.select(db.products).get();

      payload['products'] = products
          .map((e) => productSyncMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.invoices)) {
      final invoices = await db.select(db.invoices).get();
      payload['invoices'] = invoices
          .map((e) => invoiceMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.invoiceItems)) {
      final items = await db.select(db.invoiceItems).get();

      payload['invoiceItems'] = items
          .map((e) => invoiceItemMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.payments)) {
      final payments = await db.select(db.paymentHistories).get();

      payload['payments'] = payments
          .map((e) => paymentSyncMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.expenses)) {
      final expenses = await db.select(db.expenses).get();

      payload['expenses'] = expenses
          .map((e) => expenseSyncMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.category)) {
      final expenses = await db.select(db.categories).get();

      payload['categories'] = expenses
          .map((e) => categoryMapper.toMap(e, exportContext))
          .toList();
    }

    if (tables.contains(SyncTable.businessSetting)) {
      final expenses = await db.select(db.businessSettings).get();

      payload['businessSettings'] = expenses
          .map((e) => businessSettingMapper.toMap(e, exportContext))
          .toList();
    }

    return SyncPacket(
      deviceId: deviceId,
      deviceName: deviceName,
      createdAt: DateTime.now(),
      payload: payload,
    );
  }

  Future<void> importData(SyncPacket packet) async {
    await db.transaction(() async {
      for (final json in (packet.payload['customers'] as List?) ?? []) {
        await upsertCustomer(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['suppliers'] as List?) ?? []) {
        await upsertSupplier(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['products'] as List?) ?? []) {
        await upsertProduct(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['invoices'] as List?) ?? []) {
        await upsertInvoice(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['invoiceItems'] as List?) ?? []) {
        await upsertInvoiceItem(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['payments'] as List?) ?? []) {
        await upsertPayment(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['expenses'] as List?) ?? []) {
        await upsertExpense(Map<String, dynamic>.from(json));
      }
      for (final json in (packet.payload['businessSettings'] as List?) ?? []) {
        await upsertBusinessSetting(Map<String, dynamic>.from(json));
      }

      for (final json in (packet.payload['categories'] as List?) ?? []) {
        await upsertCategory(Map<String, dynamic>.from(json));
      }
    });
  }

  Future<DatabaseStatistics> getStatistics() async {
    final customers = await db.select(db.customers).get();

    final suppliers = await db.select(db.suppliers).get();

    final products = await db.select(db.products).get();

    final invoices = await db.select(db.invoices).get();

    final invoiceItems = await db.select(db.invoiceItems).get();

    final payments = await db.select(db.paymentHistories).get();

    final expenses = await db.select(db.expenses).get();
    final category = await db.select(db.categories).get();
    final businessSettingMapper = await db.select(db.businessSettings).get();

    return DatabaseStatistics(
      customers: customers.length,
      suppliers: suppliers.length,
      products: products.length,
      invoices: invoices.length,
      invoiceItems: invoiceItems.length,
      payments: payments.length,
      expenses: expenses.length,
      category: category.length,
      businessSetting: businessSettingMapper.length,
    );
  }

  Future<void> upsertCustomer(Map<String, dynamic> json) async {
    final syncId = json['syncId'] as String;
    final importContext = SyncImportContext(resolver: syncIdResolver);
    final existing = await (db.select(
      db.customers,
    )..where((tbl) => tbl.syncId.equals(syncId))).getSingleOrNull();

    final companion = customerMapper.toCompanion(json, importContext);

    if (existing == null) {
      await db.into(db.customers).insert(companion);
    } else {
      await (db.update(
        db.customers,
      )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
    }
  }

  Future<void> upsertSupplier(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);
    final syncId = json['syncId'] as String;

    final existing = await (db.select(
      db.suppliers,
    )..where((tbl) => tbl.syncId.equals(syncId))).getSingleOrNull();

    final companion = supplierMapper.toCompanion(json, importContext);

    if (existing == null) {
      await db.into(db.suppliers).insert(companion);
    } else {
      await (db.update(
        db.suppliers,
      )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
    }
  }

  Future<void> upsertProduct(Map<String, dynamic> json) async {
    try {
      final syncId = json['syncId'] as String;
      final importContext = SyncImportContext(resolver: syncIdResolver);
      final existing = await (db.select(
        db.products,
      )..where((tbl) => tbl.syncId.equals(syncId))).getSingleOrNull();

      final companion = productSyncMapper.toCompanion(json, importContext);

      // New Product
      if (existing == null) {
        await db.into(db.products).insert(companion);

        debugPrint("[SYNC] Product inserted : $syncId");

        _statistics.inserted++;

        return;
      }

      final remoteUpdatedAt = SyncValueParser.toDateTime(json['updatedAt']);

      // Local data is newer
      if (existing.updatedAt.isAfter(remoteUpdatedAt)) {
        debugPrint("[SYNC] Product skipped (local newer) : $syncId");

        _statistics.skipped++;

        return;
      }

      await (db.update(
        db.products,
      )..where((tbl) => tbl.id.equals(existing.id))).write(companion);

      debugPrint("[SYNC] Product updated : $syncId");

      _statistics.updated++;
    } catch (e, stackTrace) {
      debugPrint("[SYNC] Product import failed");
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      rethrow;
    }
  }

  Future<void> _upsertBySyncId<T>({
    required String syncId,
    required Future<T?> Function() findExisting,
    required Future<void> Function() insert,
    required Future<void> Function(T existing) update,
  }) async {
    final existing = await findExisting();

    if (existing == null) {
      await insert();
    } else {
      await update(existing);
    }
  }

  Future<void> upsertInvoice(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);

    await _upsertBySyncId(
      syncId: json['syncId'],
      findExisting: () {
        return (db.select(
          db.invoices,
        )..where((t) => t.syncId.equals(json['syncId']))).getSingleOrNull();
      },
      insert: () {
        return db
            .into(db.invoices)
            .insert(invoiceMapper.toCompanion(json, importContext));
      },
      update: (existing) {
        return (db.update(db.invoices)..where((t) => t.id.equals(existing.id)))
            .write(invoiceMapper.toCompanion(json, importContext));
      },
    );
  }

  Future<void> upsertInvoiceItem(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);
    await _upsertBySyncId(
      syncId: json['syncId'],
      findExisting: () {
        return (db.select(
          db.invoiceItems,
        )..where((t) => t.syncId.equals(json['syncId']))).getSingleOrNull();
      },
      insert: () {
        return db
            .into(db.invoiceItems)
            .insert(invoiceItemMapper.toCompanion(json, importContext));
      },
      update: (existing) {
        return (db.update(db.invoiceItems)
              ..where((t) => t.id.equals(existing.id)))
            .write(invoiceItemMapper.toCompanion(json, importContext));
      },
    );
  }

  Future<void> upsertPayment(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);
    await _upsertBySyncId(
      syncId: json['syncId'],
      findExisting: () {
        return (db.select(
          db.paymentHistories,
        )..where((t) => t.syncId.equals(json['syncId']))).getSingleOrNull();
      },
      insert: () {
        return db
            .into(db.paymentHistories)
            .insert(paymentSyncMapper.toCompanion(json, importContext));
      },
      update: (existing) {
        return (db.update(db.paymentHistories)
              ..where((t) => t.id.equals(existing.id)))
            .write(paymentSyncMapper.toCompanion(json, importContext));
      },
    );
  }

  Future<void> upsertExpense(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);
    await _upsertBySyncId(
      syncId: json['syncId'],
      findExisting: () {
        return (db.select(
          db.expenses,
        )..where((t) => t.syncId.equals(json['syncId']))).getSingleOrNull();
      },
      insert: () {
        return db
            .into(db.expenses)
            .insert(expenseSyncMapper.toCompanion(json, importContext));
      },
      update: (existing) {
        return (db.update(db.expenses)..where((t) => t.id.equals(existing.id)))
            .write(expenseSyncMapper.toCompanion(json, importContext));
      },
    );
  }

  Future<void> upsertCategory(Map<String, dynamic> json) async {
    final importContext = SyncImportContext(resolver: syncIdResolver);

    await _upsertBySyncId(
      syncId: json['syncId'],
      findExisting: () {
        return (db.select(
          db.categories,
        )..where((t) => t.syncId.equals(json['syncId']))).getSingleOrNull();
      },
      insert: () {
        return db
            .into(db.categories)
            .insert(categoryMapper.toCompanion(json, importContext));
      },
      update: (existing) {
        return (db.update(db.categories)
              ..where((t) => t.id.equals(existing.id)))
            .write(categoryMapper.toCompanion(json, importContext));
      },
    );
  }

  Future<void> upsertBusinessSetting(Map<String, dynamic> json) async {
    final syncId = json['syncId'] as String;
    final importContext = SyncImportContext(resolver: syncIdResolver);
    final existing = await (db.select(
      db.businessSettings,
    )..where((tbl) => tbl.syncId.equals(syncId))).getSingleOrNull();

    final companion = businessSettingMapper.toCompanion(json, importContext);

    if (existing == null) {
      await db.into(db.businessSettings).insert(companion);
    } else {
      await (db.update(
        db.businessSettings,
      )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
    }
  }
}
