import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/customers/widget/payment_history_dialog.dart';
import 'package:inventory_desktop/presentation/customers/widget/receive_payment_dialog.dart';

import '../../../core/utils/whatsapp_helper.dart';
import '../../../data/database/app_database.dart';
import '../provider/customer_provider.dart';
import '../screen/customer_profile_screen.dart';
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
              onSelectChanged: (_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomerProfileScreen(customer: customer),
                  ),
                );
              },
              cells: [
                DataCell(Text(customer.name)),

                DataCell(Text(customer.phone)),

                DataCell(Text(customer.email ?? '')),

                DataCell(
                  Text(
                    'Rs.${customer.creditBalance ?? 0}',

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
                      /// PROFILE
                      IconButton(
                        tooltip: 'Profile',
                        icon: const Icon(Icons.person, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomerProfileScreen(customer: customer),
                            ),
                          );
                        },
                      ),

                      /// RECEIVE PAYMENT
                      /*IconButton(
                        tooltip: 'Receive Payment',
                        icon: const Icon(Icons.payments, color: Colors.green),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                ReceivePaymentDialog(customer: customer),
                          );
                        },
                      ),*/

                      /// PAYMENT HISTORY
                      /*IconButton(
                        tooltip: 'Payment History',
                        icon: const Icon(Icons.history, color: Colors.orange),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                PaymentHistoryDialog(customer: customer),
                          );
                        },
                      ),*/

                      /// LEDGER
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

                      /// WHATSAPP
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.chat, color: Colors.green),
                        onSelected: (value) async {
                          switch (value) {
                            case 'chat':
                              await WhatsAppHelper.openChat(
                                phone: customer.phone,
                                message: 'Hello ${customer.name}',
                              );
                              break;

                            case 'payment':
                              await WhatsAppHelper.sendPaymentReminder(
                                phone: customer.phone,
                                customerName: customer.name,
                                amount: customer.creditBalance ?? 0,
                              );
                              break;
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'chat',
                            child: Text('Open Chat'),
                          ),
                          PopupMenuItem(
                            value: 'payment',
                            child: Text('Payment Reminder'),
                          ),
                        ],
                      ),

                      /// EDIT
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                EditCustomerDialog(customer: customer),
                          );
                        },
                      ),

                      /// DELETE
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final repo = ref.read(customerRepositoryProvider);

                          await repo.deleteCustomer(customer.id);
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
