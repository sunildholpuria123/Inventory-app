import '../../presentation/reports/model/customer_sales_model.dart';
import '../../presentation/reports/model/monthly_sales_model.dart';
import '../../presentation/reports/model/top_product_model.dart';
import '../database/app_database.dart';

class ReportsRepository {
  final AppDatabase db;

  ReportsRepository(this.db);

  /// MONTHLY SALES
  Future<List<MonthlySalesModel>> getMonthlySales() async {
    final result = await db.customSelect('''
      SELECT 
      strftime('%m', created_at) as month,
      SUM(grand_total) as total
      FROM invoices
      GROUP BY month
      ORDER BY month ASC
      ''').get();

    return result.map((e) {
      return MonthlySalesModel(
        month: e.data['month'].toString(),

        total: (e.data['total'] as num).toDouble(),
      );
    }).toList();
  }

  /// TOP SELLING PRODUCTS
  Future<List<TopProductModel>> getTopProducts() async {
    final result = await db.customSelect('''
      SELECT 
      product_name,
      SUM(quantity) as qty,
      SUM(total) as revenue
      FROM invoice_items
      GROUP BY product_name
      ORDER BY qty DESC
      LIMIT 5
      ''').get();

    return result.map((e) {
      return TopProductModel(
        productName: e.data['product_name'].toString(),

        totalQty: e.data['qty'] as int,

        revenue: (e.data['revenue'] as num).toDouble(),
      );
    }).toList();
  }

  /// TOTAL PROFIT
  Future<double> getProfit() async {
    final sales = await db.customSelect('''
      SELECT SUM(grand_total)
      as total
      FROM invoices
      ''').getSingle();

    final purchases = await db.customSelect('''
      SELECT SUM(total)
      as total
      FROM purchases
      ''').getSingle();

    final saleAmount = (sales.data['total'] ?? 0).toDouble();

    final purchaseAmount = (purchases.data['total'] ?? 0).toDouble();

    return saleAmount - purchaseAmount;
  }

  /// INVENTORY VALUE
  Future<double> getInventoryValue() async {
    final products = await db.select(db.products).get();

    double total = 0;

    for (final product in products) {
      total += product.stockQty * product.purchasePrice;
    }

    return total;
  }

  Future<double> getFilteredRevenue({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    String query = '''
    SELECT SUM(grand_total)
    as total
    FROM invoices
  ''';

    if (startDate != null && endDate != null) {
      query +=
          '''
      WHERE created_at
      BETWEEN '${startDate.toIso8601String()}'
      AND '${endDate.toIso8601String()}'
    ''';
    }

    final result = await db.customSelect(query).getSingle();

    return (result.data['total'] ?? 0).toDouble();
  }

  Future<List<CustomerSalesModel>> getTopCustomers() async {
    final result = await db.customSelect('''
    SELECT
    customer_name,
    COUNT(*) as invoices,
    SUM(grand_total) as total
    FROM invoices
    GROUP BY customer_name
    ORDER BY total DESC
    LIMIT 5
    ''').get();

    return result.map((e) {
      return CustomerSalesModel(
        customerName: e.data['customer_name'].toString(),

        invoices: e.data['invoices'] as int,

        total: (e.data['total'] as num).toDouble(),
      );
    }).toList();
  }

  Future<Map<String, double>> getExpenseAnalytics() async {
    final result = await db.customSelect('''
    SELECT
    category,
    SUM(amount) as total
    FROM expenses
    GROUP BY category
    ''').get();

    final Map<String, double> data = {};

    for (final row in result) {
      data[row.data['category'].toString()] = (row.data['total'] as num)
          .toDouble();
    }

    return data;
  }

  Future<List<MonthlySalesModel>> getProfitTrend() async {
    final result = await db.customSelect('''
    SELECT
    strftime('%m', created_at)
    as month,
    SUM(grand_total) as total
    FROM invoices
    GROUP BY month
    ''').get();

    return result.map((e) {
      return MonthlySalesModel(
        month: e.data['month'].toString(),

        total: (e.data['total'] as num).toDouble(),
      );
    }).toList();
  }
}
