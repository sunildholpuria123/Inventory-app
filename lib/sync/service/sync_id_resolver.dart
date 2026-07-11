import '../../../data/database/app_database.dart';

class SyncIdResolver {
  final AppDatabase db;

  SyncIdResolver(this.db);

  //--------------------------------------------------------
  // CACHE
  //--------------------------------------------------------

  final Map<String, int> _customerCache = {};

  final Map<String, int> _supplierCache = {};

  final Map<String, int> _productCache = {};

  final Map<String, int> _invoiceCache = {};

  //--------------------------------------------------------
  // CUSTOMER
  //--------------------------------------------------------

  Future<int?> customerId(
      String? syncId,
      ) async {
    if (syncId == null) {
      return null;
    }

    if (_customerCache.containsKey(syncId)) {
      return _customerCache[syncId];
    }

    final customer =
    await (db.select(db.customers)
      ..where(
            (tbl) => tbl.syncId.equals(syncId),
      ))
        .getSingleOrNull();

    if (customer == null) {
      return null;
    }

    _customerCache[syncId] = customer.id;

    return customer.id;
  }

  //--------------------------------------------------------
  // SUPPLIER
  //--------------------------------------------------------

  Future<int?> supplierId(
      String? syncId,
      ) async {
    if (syncId == null) {
      return null;
    }

    if (_supplierCache.containsKey(syncId)) {
      return _supplierCache[syncId];
    }

    final supplier =
    await (db.select(db.suppliers)
      ..where(
            (tbl) => tbl.syncId.equals(syncId),
      ))
        .getSingleOrNull();

    if (supplier == null) {
      return null;
    }

    _supplierCache[syncId] = supplier.id;

    return supplier.id;
  }

  //--------------------------------------------------------
  // PRODUCT
  //--------------------------------------------------------

  Future<int?> productId(
      String? syncId,
      ) async {
    if (syncId == null) {
      return null;
    }

    if (_productCache.containsKey(syncId)) {
      return _productCache[syncId];
    }

    final product =
    await (db.select(db.products)
      ..where(
            (tbl) => tbl.syncId.equals(syncId),
      ))
        .getSingleOrNull();

    if (product == null) {
      return null;
    }

    _productCache[syncId] = product.id;

    return product.id;
  }

  //--------------------------------------------------------
  // INVOICE
  //--------------------------------------------------------

  Future<int?> invoiceId(
      String? syncId,
      ) async {
    if (syncId == null) {
      return null;
    }

    if (_invoiceCache.containsKey(syncId)) {
      return _invoiceCache[syncId];
    }

    final invoice =
    await (db.select(db.invoices)
      ..where(
            (tbl) => tbl.syncId.equals(syncId),
      ))
        .getSingleOrNull();

    if (invoice == null) {
      return null;
    }

    _invoiceCache[syncId] = invoice.id;

    return invoice.id;
  }

  //--------------------------------------------------------
  // CLEAR
  //--------------------------------------------------------

  void clear() {
    _customerCache.clear();
    _supplierCache.clear();
    _productCache.clear();
    _invoiceCache.clear();
  }
}