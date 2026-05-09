import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../customers/provider/customer_provider.dart';
import '../provider/sales_provider.dart';

class CustomerDropdown
    extends ConsumerWidget {
  const CustomerDropdown({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final customers =
    ref.watch(customersProvider);

    return customers.when(
      data: (items) {
        return DropdownButtonFormField(
          decoration:
          const InputDecoration(
            labelText:
            'Select Customer',
          ),

          items: items.map((customer) {
            return DropdownMenuItem(
              value: customer,

              child: Text(
                customer.name,
              ),
            );
          }).toList(),

          onChanged: (value) {
            ref
                .read(
              selectedCustomerProvider
                  .notifier,
            )
                .state = value;
          },
        );
      },

      loading: () =>
      const CircularProgressIndicator(),

      error: (e, _) =>
          Text(e.toString()),
    );
  }
}