import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // PRODUCTS

  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }

  Stream<List<Product>> watchProducts() {
    return select(products).watch();
  }

  Future<int> insertProduct(
      ProductsCompanion data,
      ) {
    return into(products).insert(data);
  }

  Future updateProduct(Product data) {
    return update(products).replace(data);
  }

  Future deleteProduct(int id) {
    return (delete(products)
      ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // CUSTOMERS

  Future<List<Customer>> getAllCustomers() {
    return select(customers).get();
  }

  Future<int> insertCustomer(
      CustomersCompanion data,
      ) {
    return into(customers).insert(data);
  }

  // SALES

  Future<int> createSale(
      SalesCompanion data,
      ) {
    return into(sales).insert(data);
  }

  Future<int> insertSaleItem(
      SaleItemsCompanion data,
      ) {
    return into(saleItems).insert(data);
  }

  // EXPENSES

  Future<int> insertExpense(
      ExpensesCompanion data,
      ) {
    return into(expenses).insert(data);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder =
    await getApplicationDocumentsDirectory();

    final file = File(
      p.join(
        dbFolder.path,
        'inventory.sqlite',
      ),
    );

    return NativeDatabase(file);
  });
}