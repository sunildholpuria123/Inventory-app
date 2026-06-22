import 'package:flutter/material.dart';

import '../widgets/ai_purchase_assistant_card.dart';
import '../widgets/inventory_optimization_card.dart';
import '../widgets/purchase_budget_card.dart';
import '../widgets/purchase_order_card.dart';
import '../widgets/seasonal_forecast_card.dart';
import '../widgets/supplier_recommendation_card.dart';
import '../widgets/supplier_risk_card.dart';

class PurchaseAiDashboardScreen extends StatelessWidget {
  const PurchaseAiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Intelligence'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          AiPurchaseAssistantCard(),
          SizedBox(height: 20),

          PurchaseOrderCard(),
          SizedBox(height: 20),

          SeasonalForecastCard(),
          SizedBox(height: 20),

          SupplierRiskCard(),
          SizedBox(height: 20),

          SupplierRecommendationCard(),
          SizedBox(height: 20),

          PurchaseBudgetCard(),
          SizedBox(height: 20),

          InventoryOptimizationCard(),
        ],
      ),
    );
  }
}