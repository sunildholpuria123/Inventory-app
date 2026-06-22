import 'dart:math';

import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';

class DemoDataService {
  final AppDatabase db;

  DemoDataService(this.db);

  final _random = Random();

  Future<void> generate() async {
    await db.transaction(() async {
      await _clearData();

      final categoryIds = await _insertCategories();
      final supplierIds = await _insertSuppliers();
      final customerIds = await _insertCustomers();

      final productIds = await _insertProducts(categoryIds);

      await insertDummyVariants();

      await _insertPurchases(supplierIds, productIds);

      await _insertSales(customerIds, productIds);

      await _insertPriceHistory(supplierIds, productIds);
    });
  }

  Future<void> _clearData() async {
    await db.delete(db.productPriceHistories).go();
    await db.delete(db.saleItems).go();
    await db.delete(db.sales).go();
    await db.delete(db.purchaseItems).go();
    await db.delete(db.purchases).go();
    await db.delete(db.paymentHistories).go();
    await db.delete(db.supplierPaymentHistories).go();
    await db.delete(db.products).go();
    await db.delete(db.customers).go();
    await db.delete(db.suppliers).go();
    await db.delete(db.categories).go();
  }

  Future<List<int>> _insertCategories() async {
    final categories = [
      (name: 'Tiles', pricingType: 'QUANTITY', unit: 'Box'),
      (name: 'Granite', pricingType: 'AREA', unit: 'PCS'),
      (name: 'Marble', pricingType: 'AREA', unit: 'Sqft'),
      (name: 'Sanitary', pricingType: 'QUANTITY', unit: 'PCS'),
      (name: 'Accessories', pricingType: 'QUANTITY', unit: 'PCS'),
    ];

    final ids = <int>[];

    for (final c in categories) {
      final id = await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              name: c.name,
              pricingType: c.pricingType,
              unit: c.unit,
            ),
          );

      ids.add(id);
    }

    return ids;
  }

  Future<List<int>> _insertSuppliers() async {
    final data = [
      ('ABC Granite', '9876543210'),
      ('Rajasthan Marble', '9876543211'),
      ('Premium Tiles', '9876543212'),
      ('Asian Ceramics', '9876543213'),
      ('Stone World', '9876543214'),
    ];

    final ids = <int>[];

    for (final item in data) {
      final id = await db
          .into(db.suppliers)
          .insert(
            SuppliersCompanion.insert(
              name: item.$1,
              phone: item.$2,
              creditBalance: Value(_random.nextInt(50000).toDouble()),
              gstNumber: const Value('22AAAAA0000A1Z5'),
            ),
          );

      ids.add(id);
    }

    return ids;
  }

  Future<List<int>> _insertCustomers() async {
    final names = [
      'Amit Sharma',
      'Rohit Gupta',
      'Deepak Jain',
      'Mohit Singh',
      'Suresh Verma',
    ];

    final ids = <int>[];

    for (final name in names) {
      final id = await db
          .into(db.customers)
          .insert(
            CustomersCompanion.insert(
              name: name,
              phone: '99911${_random.nextInt(99999)}',
              creditBalance: Value(_random.nextInt(20000).toDouble()),
            ),
          );

      ids.add(id);
    }

    return ids;
  }

  Future<List<int>> _insertProducts(List<int> categoryIds) async {
    final products = [
      ('Black Granite', 80.0, 120.0),
      ('White Marble', 100.0, 150.0),
      ('Floor Tile 2x2', 40.0, 60.0),
      ('Wall Tile', 35.0, 55.0),
      ('Italian Marble', 150.0, 220.0),
      ('Kota Stone', 45.0, 70.0),
      ('Parking Tile', 30.0, 45.0),
      ('Ceramic Tile', 25.0, 40.0),
    ];

    final ids = <int>[];

    for (final p in products) {
      final id = await db
          .into(db.products)
          .insert(
            ProductsCompanion.insert(
              categoryId: categoryIds[_random.nextInt(categoryIds.length)],
              name: p.$1,
              purchasePrice: p.$2,
              sellingPrice: p.$3,
              stockQty: 20 + _random.nextInt(300),
              minStock: 10 + _random.nextInt(30),
            ),
          );

      ids.add(id);
    }

    return ids;
  }

  Future<void> _insertPurchases(
    List<int> supplierIds,
    List<int> productIds,
  ) async {
    for (int i = 0; i < 50; i++) {
      final supplier =
          await (db.select(db.suppliers)..where(
                (t) => t.id.equals(
                  supplierIds[_random.nextInt(supplierIds.length)],
                ),
              ))
              .getSingle();

      final total = 5000 + _random.nextInt(50000);

      final purchaseId = await db
          .into(db.purchases)
          .insert(
            PurchasesCompanion.insert(
              purchaseNo: 'PUR-${1000 + i}',
              supplierName: supplier.name,
              supplierPhone: Value(supplier.phone),
              total: total.toDouble(),
            ),
          );

      for (int j = 0; j < 3; j++) {
        final product =
            await (db.select(db.products)..where(
                  (t) => t.id.equals(
                    productIds[_random.nextInt(productIds.length)],
                  ),
                ))
                .getSingle();

        final qty = 5 + _random.nextInt(20);

        await db
            .into(db.purchaseItems)
            .insert(
              PurchaseItemsCompanion.insert(
                purchaseId: purchaseId,
                productId: product.id,
                productName: product.name,
                quantity: qty,
                purchasePrice: product.purchasePrice,
                total: qty * product.purchasePrice,
              ),
            );
      }
    }
  }

  Future<void> _insertSales(List<int> customerIds, List<int> productIds) async {
    for (int i = 0; i < 100; i++) {
      final customerId = customerIds[_random.nextInt(customerIds.length)];

      final total = 500 + _random.nextInt(10000);

      final saleId = await db
          .into(db.sales)
          .insert(
            SalesCompanion.insert(
              customerId: customerId,
              invoiceNo: 'INV-${1000 + i}',
              total: total.toDouble(),
              discount: 0,
              tax: total * 0.18,
              grandTotal: total * 1.18,
              paymentStatus: _random.nextBool() ? 'Paid' : 'Due',
            ),
          );

      for (int j = 0; j < 3; j++) {
        final product =
            await (db.select(db.products)..where(
                  (t) => t.id.equals(
                    productIds[_random.nextInt(productIds.length)],
                  ),
                ))
                .getSingle();

        final qty = 1 + _random.nextInt(10);

        await db
            .into(db.saleItems)
            .insert(
              SaleItemsCompanion.insert(
                saleId: saleId,
                productId: product.id,
                qty: qty,
                price: product.sellingPrice,
                subtotal: qty * product.sellingPrice,
              ),
            );
      }
    }
  }

  Future<void> _insertPriceHistory(
    List<int> supplierIds,
    List<int> productIds,
  ) async {
    for (final productId in productIds) {
      double oldPrice = 50 + _random.nextInt(100).toDouble();

      for (int i = 0; i < 5; i++) {
        final newPrice = oldPrice + _random.nextInt(10);

        final inflation = ((newPrice - oldPrice) / oldPrice) * 100;

        await db
            .into(db.productPriceHistories)
            .insert(
              ProductPriceHistoriesCompanion.insert(
                productId: productId,
                supplierId: Value(
                  supplierIds[_random.nextInt(supplierIds.length)],
                ),
                oldPurchasePrice: oldPrice,
                newPurchasePrice: newPrice,
                oldSellingPrice: oldPrice * 1.4,
                newSellingPrice: newPrice * 1.4,
                inflationPercentage: Value(inflation),
                remarks: const Value('Demo Data'),
              ),
            );

        oldPrice = newPrice;
      }
    }
  }

  Future<void> insertDummyVariants() async {
    final products = await db.select(db.products).get();

    final random = Random();

    for (final product in products) {
      final variants = _getVariantsForProduct(product.name);

      for (final variant in variants) {
        await db
            .into(db.productVariants)
            .insert(
              ProductVariantsCompanion.insert(
                productId: product.id,

                variantName: variant.name,

                thickness: Value(variant.thickness),

                color: Value(variant.color),

                size: Value(variant.size),

                purchasePrice: product.purchasePrice + random.nextInt(20),

                sellingPrice: product.sellingPrice + random.nextInt(30),

                stockQty: (20 + random.nextInt(150).toDouble()),
              ),
            );
      }
    }
  }

  List<_VariantData> _getVariantsForProduct(String productName) {
    final name = productName.toLowerCase();

    if (name.contains('granite')) {
      return const [
        _VariantData(
          name: 'Polished 16mm',
          thickness: '16mm',
          color: 'Black',
          size: '8x4',
        ),
        _VariantData(
          name: 'Polished 18mm',
          thickness: '18mm',
          color: 'Black',
          size: '8x4',
        ),
        _VariantData(
          name: 'Leather Finish',
          thickness: '20mm',
          color: 'Black',
          size: '8x4',
        ),
        _VariantData(
          name: 'Honed Finish',
          thickness: '20mm',
          color: 'Black',
          size: '8x4',
        ),
      ];
    }

    if (name.contains('marble')) {
      return const [
        _VariantData(
          name: 'Italian Finish',
          thickness: '18mm',
          color: 'White',
          size: '8x4',
        ),
        _VariantData(
          name: 'Premium',
          thickness: '20mm',
          color: 'White',
          size: '8x4',
        ),
        _VariantData(
          name: 'Commercial',
          thickness: '16mm',
          color: 'White',
          size: '8x4',
        ),
      ];
    }

    if (name.contains('tile')) {
      return const [
        _VariantData(name: 'Glossy', color: 'White', size: '600x600'),
        _VariantData(name: 'Matte', color: 'Grey', size: '600x600'),
        _VariantData(name: 'Digital Print', color: 'Beige', size: '600x1200'),
        _VariantData(name: 'Premium', color: 'Brown', size: '800x800'),
      ];
    }

    return const [
      _VariantData(name: 'Standard'),
      _VariantData(name: 'Premium'),
    ];
  }
}

class _VariantData {
  final String name;
  final String? thickness;
  final String? color;
  final String? size;

  const _VariantData({
    required this.name,
    this.thickness,
    this.color,
    this.size,
  });
}
