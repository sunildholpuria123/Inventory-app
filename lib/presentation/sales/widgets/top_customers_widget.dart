import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../customers/provider/customer_provider.dart';
import '../../customers/screen/customer_profile_screen.dart';
import '../provider/sales_analytics_provider.dart';

class TopCustomersWidget extends ConsumerWidget {
  const TopCustomersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topCustomers = ref.watch(topCustomersProvider);
    final customers = ref.watch(customersProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: topCustomers.when(
          data: (items) {
            if (items.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Customers',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No customer data available'),
                    ),
                  ),
                ],
              );
            }

            return customers.when(
              data: (customerList) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Customers',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 16),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final item = items[index];

                        final customer = customerList.firstWhere(
                          (e) => e.id == item.customerId,
                        );

                        return ListTile(
                          leading: CircleAvatar(child: Text(customer.name[0])),
                          title: Text(customer.name),
                          subtitle: Text(
                            'Sales ₹${item.amount.toStringAsFixed(0)}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CustomerProfileScreen(customer: customer),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
        ),
      ),
    );
  }
}
