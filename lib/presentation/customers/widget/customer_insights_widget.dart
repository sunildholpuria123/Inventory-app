import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/customer_insights_provider.dart';
import 'customer_kpi_card.dart';

class CustomerInsightsWidget extends ConsumerWidget {
  const CustomerInsightsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(customerInsightsProvider);

    return insights.when(
      data: (data) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: 250,
              child: CustomerKpiCard(
                title: 'Active',
                value: '${data.activeCustomers}',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 250,
              child: CustomerKpiCard(
                title: 'Inactive',
                value: '${data.inactiveCustomers}',
                icon: Icons.person_off,
                color: Colors.orange,
              ),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
  }
}
