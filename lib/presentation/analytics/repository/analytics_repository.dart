import '../../../data/database/app_database.dart';
import '../model/ai_purchase_assistant_model.dart';
import '../model/demand_prediction_model.dart';
import '../model/inventory_optimization_model.dart';
import '../model/price_recommendation_model.dart';
import '../model/purchase_budget_model.dart';
import '../model/purchase_forecast_model.dart';
import '../model/purchase_order_model.dart';
import '../model/reorder_suggestion_model.dart';
import '../model/seasonal_forecast_model.dart';
import '../model/supplier_recommendation_model.dart';
import '../model/supplier_risk_model.dart';
import '../model/supplier_score_model.dart';

class AnalyticsRepository {
  final AppDatabase db;

  AnalyticsRepository(this.db);

  Future<List<PurchaseForecastModel>> getPurchaseForecast() async {
    final purchases = await db.select(db.purchases).get();

    if (purchases.isEmpty) {
      return [];
    }

    final monthly = <String, double>{};

    for (final purchase in purchases) {
      final key = '${purchase.createdAt.year}-${purchase.createdAt.month}';

      monthly[key] = (monthly[key] ?? 0) + purchase.total;
    }

    final result = monthly.entries
        .map((e) => PurchaseForecastModel(month: e.key, amount: e.value))
        .toList();
    result.sort((a, b) => a.month.compareTo(b.month));
    if (result.length >= 3) {
      final lastThree = result.sublist(result.length - 3);

      final avg =
          lastThree.fold<double>(0, (sum, e) => sum + e.amount) /
          lastThree.length;

      result.add(PurchaseForecastModel(month: 'Forecast', amount: avg));
    }
    return result;
  }

  Future<List<DemandPredictionModel>> getDemandPrediction() async {
    final items = await db.select(db.invoiceItems).get();

    final map = <int, DemandPredictionModel>{};

    for (final item in items) {
      if (map.containsKey(item.productId)) {
        final old = map[item.productId]!;

        map[item.productId] = DemandPredictionModel(
          productId: old.productId,
          productName: old.productName,
          predictedQty: old.predictedQty + item.quantity,
        );
      } else {
        map[item.productId] = DemandPredictionModel(
          productId: item.productId,
          productName: item.productName,
          predictedQty: item.quantity,
        );
      }
    }

    return map.values.toList()
      ..sort((a, b) => b.predictedQty.compareTo(a.predictedQty));
  }

  Future<List<SupplierScoreModel>> getSupplierScores() async {
    final purchases = await db.select(db.purchases).get();

    final map = <String, double>{};

    for (final purchase in purchases) {
      map[purchase.supplierName] =
          (map[purchase.supplierName] ?? 0) + purchase.total;
    }

    final result = map.entries.map((e) {
      final score = (e.value / 10000).clamp(0, 100);

      return SupplierScoreModel(
        supplierName: e.key,
        score: score.toDouble(),
        totalPurchase: e.value,
        returnRate: 0,
      );
    }).toList();

    result.sort((a, b) => b.score.compareTo(a.score));

    return result;
  }

  Future<List<PriceRecommendationModel>> getPriceRecommendations() async {
    final products = await db.select(db.products).get();

    return products.map((product) {
      final purchase = product.purchasePrice;

      final recommendedPurchase = purchase * 1.10;

      final recommendedSelling = recommendedPurchase * 1.25;

      return PriceRecommendationModel(
        productName: product.name,
        currentPurchase: purchase,
        recommendedPurchase: recommendedPurchase,
        recommendedSelling: recommendedSelling,
      );
    }).toList();
  }

  Future<List<ReorderSuggestionModel>> getReorderSuggestions() async {
    final products = await db.select(db.products).get();

    final result = <ReorderSuggestionModel>[];

    for (final product in products) {
      if (product.stockQty <= product.minStock) {
        final qty = (product.minStock * 2) - product.stockQty;

        result.add(
          ReorderSuggestionModel(
            productId: product.id,
            productName: product.name,
            stock: product.stockQty,
            suggestedQty: qty,
          ),
        );
      }
    }

    return result;
  }

  Future<List<PurchaseOrderModel>> generatePurchaseOrders() async {
    final products = await db.select(db.products).get();

    final suppliers = await db.select(db.suppliers).get();

    final defaultSupplier = suppliers.isEmpty
        ? 'Unknown'
        : suppliers.first.name;

    final result = <PurchaseOrderModel>[];

    for (final product in products) {
      if (product.stockQty <= product.minStock) {
        final qty = (product.minStock * 2) - product.stockQty;

        if (qty > 0) {
          result.add(
            PurchaseOrderModel(
              productId: product.id,
              productName: product.name,
              supplierName: defaultSupplier,
              quantity: qty,
              estimatedCost: qty * product.purchasePrice,
            ),
          );
        }
      }
    }

    return result;
  }

  Future<List<SeasonalForecastModel>> getSeasonalForecast() async {
    final invoices = await db.select(db.sales).get();

    final monthly = <String, double>{};

    for (final sale in invoices) {
      final month = '${sale.createdAt.month}'.padLeft(2, '0');

      monthly[month] = (monthly[month] ?? 0) + sale.grandTotal;
    }

    return monthly.entries
        .map(
          (e) => SeasonalForecastModel(month: e.key, forecastAmount: e.value),
        )
        .toList()
      ..sort((a, b) => a.month.compareTo(b.month));
  }

  Future<List<SupplierRiskModel>> getSupplierRiskAnalysis() async {
    final purchases = await db.select(db.purchases).get();

    final map = <String, double>{};

    for (final purchase in purchases) {
      map[purchase.supplierName] =
          (map[purchase.supplierName] ?? 0) + purchase.total;
    }

    return map.entries.map((e) {
      final total = e.value;

      double risk = 0;

      if (total < 10000) {
        risk = 80;
      } else if (total < 50000) {
        risk = 50;
      } else {
        risk = 20;
      }

      String level;

      if (risk >= 70) {
        level = 'High';
      } else if (risk >= 40) {
        level = 'Medium';
      } else {
        level = 'Low';
      }

      return SupplierRiskModel(
        supplierName: e.key,
        riskScore: risk,
        riskLevel: level,
      );
    }).toList()..sort((a, b) => b.riskScore.compareTo(a.riskScore));
  }

  Future<List<InventoryOptimizationModel>> getInventoryOptimization() async {
    final products = await db.select(db.products).get();

    final invoiceItems = await db.select(db.invoiceItems).get();

    final salesMap = <int, int>{};

    for (final item in invoiceItems) {
      salesMap[item.productId] =
          (salesMap[item.productId] ?? 0) + item.quantity;
    }

    final result = <InventoryOptimizationModel>[];

    for (final product in products) {
      final sold = salesMap[product.id] ?? 0;

      final optimal = sold == 0 ? product.minStock : sold * 2;

      final reorder = optimal - product.stockQty;

      result.add(
        InventoryOptimizationModel(
          productId: product.id,
          productName: product.name,
          currentStock: product.stockQty,
          optimalStock: optimal,
          reorderQty: reorder < 0 ? 0 : reorder,
        ),
      );
    }

    return result;
  }

  Future<List<AiPurchaseAssistantModel>> getAiPurchaseSuggestions() async {
    final products = await db.select(db.products).get();

    final suppliers = await db.select(db.suppliers).get();

    final supplier = suppliers.isEmpty ? 'Unknown' : suppliers.first.name;

    final result = <AiPurchaseAssistantModel>[];

    for (final product in products) {
      final demand = product.minStock * 3;

      final purchase = demand - product.stockQty;

      if (purchase > 0) {
        result.add(
          AiPurchaseAssistantModel(
            productName: product.name,
            currentStock: product.stockQty,
            predictedDemand: demand,
            suggestedPurchase: purchase,
            supplierName: supplier,
            estimatedCost: purchase * product.purchasePrice,
          ),
        );
      }
    }

    return result;
  }

  Future<List<SupplierRecommendationModel>> getSupplierRecommendations() async {
    final suppliers = await db.select(db.suppliers).get();

    final result = <SupplierRecommendationModel>[];

    for (final supplier in suppliers) {
      final score = 100 - (supplier.creditBalance / 1000);

      result.add(
        SupplierRecommendationModel(
          supplierName: supplier.name,
          score: score.clamp(0, 100),
        ),
      );
    }

    result.sort((a, b) => b.score.compareTo(a.score));

    return result;
  }

  Future<PurchaseBudgetModel> getPurchaseBudget() async {
    final purchases = await db.select(db.purchases).get();

    final projected = purchases.fold<double>(0, (sum, e) => sum + e.total);

    const budget = 500000.0;

    return PurchaseBudgetModel(
      monthlyBudget: budget,
      projectedExpense: projected,
    );
  }
}
