import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_analytics_card.dart';
import '../provider/customer_analytics_provider.dart';

class CustomerAnalyticsWidget
    extends ConsumerWidget {
  const CustomerAnalyticsWidget({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final analytics =
    ref.watch(
      customerAnalyticsProvider,
    );

    return analytics.when(
      data: (data) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: 250,
              child:
              SalesAnalyticsCard(
                title:
                'Customers',
                value:
                '${data.totalCustomers}',
                icon:
                Icons.people,
                color:
                Colors.blue,
              ),
            ),
            SizedBox(
              width: 250,
              child:
              SalesAnalyticsCard(
                title:
                'Repeat Customers',
                value:
                '${data.repeatCustomers}',
                icon:
                Icons.repeat,
                color:
                Colors.green,
              ),
            ),
            SizedBox(
              width: 250,
              child:
              SalesAnalyticsCard(
                title:
                'Avg Order',
                value:
                '₹${data.averageOrderValue.toStringAsFixed(0)}',
                icon:
                Icons.payments,
                color:
                Colors.orange,
              ),
            ),
          ],
        );
      },
      loading:
          () =>
      const CircularProgressIndicator(),
      error:
          (e, _) =>
          Text(
            e.toString(),
          ),
    );
  }
}