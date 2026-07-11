import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/customer_dashboard_provider.dart';
import '../provider/customer_provider.dart';
import '../screen/customer_profile_screen.dart';

class CustomerTimelineWidget extends ConsumerWidget {
  const CustomerTimelineWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(customerTimelineProvider);
    final customers = ref.watch(customersProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: timeline.when(
          data: (items) {
            return customers.when(
              data: (customerList) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Timeline',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                      const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final item = items[index];

                        final customer = customerList.firstWhere(
                              (e) => e.id == item.customerId,
                        );

                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(item.icon),
                          ),
                          title: Text(customer.name),
                          subtitle: Text(item.subtitle),
                          trailing: Text(
                            item.date
                                .toString()
                                .substring(0, 16),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CustomerProfileScreen(
                                      customer: customer,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
              loading: () =>
              const CircularProgressIndicator(),
              error: (e, _) => Text(e.toString()),
            );
          },
          loading: () => const SizedBox(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => Center(
            child: Text(e.toString()),
          ),
        ),
      ),
    );
  }
}