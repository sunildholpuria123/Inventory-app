import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../customers/provider/customer_provider.dart';
import '../provider/sales_provider.dart';

class CustomerDropdown extends ConsumerWidget {
  const CustomerDropdown({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final customersAsync =
    ref.watch(customersProvider);

    final selectedCustomer =
    ref.watch(
      selectedCustomerProvider,
    );

    return customersAsync.when(
      data: (customers) {
        return DropdownButtonFormField<
            int>(
          value:
          selectedCustomer?.id,

          decoration:
          const InputDecoration(
            labelText:
            'Select Customer',

            border:
            OutlineInputBorder(),
          ),

          isExpanded: true,

          items: customers
              .map(
                (
                Customer customer,
                ) {
              return DropdownMenuItem<
                  int>(
                value:
                customer.id,

                child: Text(
                  '${customer.name} (${customer.phone})',

                  overflow:
                  TextOverflow
                      .ellipsis,
                ),
              );
            },
          )
              .toList(),

          onChanged: (
              customerId,
              ) {
            if (customerId ==
                null) {
              ref
                  .read(
                selectedCustomerProvider
                    .notifier,
              )
                  .state = null;

              return;
            }

            final customer =
            customers.firstWhere(
                  (
                  customer,
                  ) =>
              customer.id ==
                  customerId,
            );

            ref
                .read(
              selectedCustomerProvider
                  .notifier,
            )
                .state = customer;
          },

          validator: (
              value,
              ) {
            if (value ==
                null) {
              return 'Please select customer';
            }

            return null;
          },
        );
      },

      loading: () =>
      const Center(
        child:
        CircularProgressIndicator(),
      ),

      error: (
          error,
          stack,
          ) =>
          Text(
            'Error: $error',
          ),
    );
  }
}