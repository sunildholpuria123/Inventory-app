import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/core/utils/responsive_helper.dart';

import '../provider/customer_provider.dart';
import '../widget/add_customer_dialog.dart';
import '../widget/customer_card_list.dart' show CustomerCardList;
import '../widget/customer_table.dart';

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customers',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AddCustomerDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Customer'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Customer',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(customerSearchProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: customers.when(
                data: (items) {
                  final search = ref.watch(customerSearchProvider);

                  final filtered = items.where((customer) {
                    return customer.name.toLowerCase().contains(
                      search.toLowerCase(),
                    );
                  }).toList();

                  return ResponsiveHelper.isMobile(context)
                      ? CustomerCardList(customers: filtered)
                      : CustomerTable(customers: filtered);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
