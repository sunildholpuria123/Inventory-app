import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_credit_provider.dart';

final aiCustomerInsightsProvider = FutureProvider<List<String>>((ref) async {
  final credit = await ref.watch(customerCreditProvider.future);

  final insights = <String>[];

  if (credit.totalDue > 100000) {
    insights.add('Outstanding dues are high. Focus on collections.');
  }

  if (credit.customersWithDue > 10) {
    insights.add('Many customers have pending balances.');
  }

  insights.add('Reward repeat customers with loyalty offers.');

  return insights;
});
