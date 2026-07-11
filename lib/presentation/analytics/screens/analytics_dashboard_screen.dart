import 'package:flutter/material.dart';

import '../widgets/ai_price_recommendation_card.dart';
import '../widgets/ai_purchase_assistant_card.dart';
import '../widgets/demand_prediction_card.dart';
import '../widgets/forecast_chart_widget.dart';
import '../widgets/inventory_optimization_card.dart';
import '../widgets/purchase_budget_card.dart';
import '../widgets/purchase_forecast_card.dart';
import '../widgets/purchase_order_card.dart';
import '../widgets/reorder_suggestion_card.dart';
import '../widgets/seasonal_forecast_card.dart';
import '../widgets/supplier_recommendation_card.dart';
import '../widgets/supplier_risk_card.dart';
import '../widgets/supplier_score_card.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          PurchaseForecastCard(),
          SizedBox(height: 20),
          DemandPredictionCard(),
          SizedBox(height: 20),
          SupplierScoreCard(),
          SizedBox(height: 20),
          AiPriceRecommendationCard(),
          SizedBox(height: 20),
          ReorderSuggestionCard(),
          SizedBox(height: 20),
          ForecastChartWidget(),
          PurchaseOrderCard(),
          SizedBox(height: 20),

          SeasonalForecastCard(),

          SizedBox(height: 20),
          SupplierRiskCard(),
          SizedBox(height: 20),

          InventoryOptimizationCard(),
          SizedBox(height: 20),
          AiPurchaseAssistantCard(),
          SizedBox(height: 20),

          SupplierRecommendationCard(),
          SizedBox(height: 20),

          PurchaseBudgetCard(),
        ],
      ),
    );
  }
}
