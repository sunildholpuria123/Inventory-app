import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_provider.dart';
import '../screen/customer_ledger_screen.dart' show CustomerLedgerScreen;
import 'edit_customer_dialog.dart';

class CustomerTable extends ConsumerWidget {
  final List<Customer> customers;

  const CustomerTable({super.key, required this.customers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          dataRowMinHeight: 60,
          dataRowMaxHeight: 60,
          headingRowHeight: 60,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Credit')),
            DataColumn(label: Text('Actions')),
          ],

          rows: customers.map((customer) {
            return DataRow(
              cells: [
                DataCell(Text(customer.name)),

                DataCell(Text(customer.phone)),

                DataCell(Text(customer.email ?? '')),

                DataCell(
                  Text(
                    '₹${customer.creditBalance ?? 0}',

                    style: TextStyle(
                      color: (customer.creditBalance ?? 0) > 0
                          ? Colors.red
                          : Colors.green,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                EditCustomerDialog(customer: customer),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),

                      IconButton(
                        onPressed: () async {
                          final repo = ref.read(customerRepositoryProvider);

                          await repo.deleteCustomer(customer.id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      IconButton(
                        tooltip: 'Ledger',

                        icon: const Icon(
                          Icons.receipt_long,
                          color: Colors.blue,
                        ),

                        onPressed: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomerLedgerScreen(customer: customer),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
