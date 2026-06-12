import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:inventory_desktop/data/database/tables/product_variants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/invoice_items_table.dart';
import 'tables/invoices_table.dart';
import 'tables/users_table.dart';
import 'tables/categories_table.dart';
import 'tables/products_table.dart';
import 'tables/customers_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/sales_table.dart';
import 'tables/sale_items_table.dart';
import 'tables/purchases_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/expenses_table.dart';
import 'tables/payment_histories.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Categories,
    Products,
    Customers,
    Suppliers,
    Sales,
    SaleItems,
    Purchases,
    PurchaseItems,
    Expenses,
    Invoices,
    InvoiceItems,
    PaymentHistories,
    ProductVariants,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  // PRODUCTS

  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }

  Stream<List<Product>> watchProducts() {
    return select(products).watch();
  }

  Future<int> insertProduct(ProductsCompanion data) {
    return into(products).insert(data);
  }

  Future updateProduct(Product data) {
    return update(products).replace(data);
  }

  Future deleteProduct(int id) {
    return (delete(products)..where((tbl) => tbl.id.equals(id))).go();
  }

  // CUSTOMERS

  Future<int> insertCustomer(CustomersCompanion data) {
    return into(customers).insert(data);
  }

  Future<List<Customer>> getAllCustomers() {
    return select(customers).get();
  }

  // SALES

  Future<int> createSale(SalesCompanion data) {
    return into(sales).insert(data);
  }

  Future<int> insertSaleItem(SaleItemsCompanion data) {
    return into(saleItems).insert(data);
  }

  // EXPENSES

  Future<int> insertExpense(ExpensesCompanion data) {
    return into(expenses).insert(data);
  }

  Stream<List<Customer>> watchCustomers() {
    return select(customers).watch();
  }

  Future updateCustomer(Customer customer) {
    return update(customers).replace(customer);
  }

  Future deleteCustomer(int id) {
    return (delete(customers)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clearDatabase() async {
    await batch((batch) {
      batch.deleteAll(products);
      batch.deleteAll(customers);
      // batch.deleteAll(invoices);
      batch.deleteAll(expenses);
      batch.deleteAll(suppliers);
      batch.deleteAll(purchases);
    });
  }

  /// WATCH ALL PRODUCTS
  Stream<List<Product>> watchAllProducts() {
    return select(products).watch();
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

    },

    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(products, products.sku);
      }
    },
  );

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(p.join(dbFolder.path, 'inventory.sqlite'));
    print(file.path);

    return NativeDatabase(file);
  });
}
