import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/presentation/customers/widget/payment_history_dialog.dart';
import 'package:inventory_desktop/presentation/customers/widget/receive_payment_dialog.dart';

import '../../../core/utils/whatsapp_helper.dart';
import '../../../data/database/app_database.dart';
import '../provider/customer_provider.dart';
import '../screen/customer_profile_screen.dart';
import '../screen/customer_ledger_screen.dart';
import 'edit_customer_dialog.dart';

class CustomerCardList extends ConsumerWidget {
  final List<Customer> customers;

  const CustomerCardList({super.key, required this.customers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: customers.length,

      itemBuilder: (context, index) {
        final customer = customers[index];

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerProfileScreen(customer: customer),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          customer.name.substring(0, 1).toUpperCase(),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              customer.name,

                              style: const TextStyle(
                                fontSize: 18,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(customer.phone),

                            if (customer.email != null) Text(customer.email!),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      OutlinedButton.icon(
                        icon: const Icon(
                          Icons.chat,
                        ),
                        label: const Text(
                          'WhatsApp',
                        ),
                        onPressed: () async {
                          await WhatsAppHelper.openChat(
                            phone: customer.phone,
                            message:
                            'Hello ${customer.name}',
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        'Credit: Rs.${customer.creditBalance.toStringAsFixed(2)}',

                        style: TextStyle(
                          color: customer.creditBalance > 0
                              ? Colors.red
                              : Colors.green,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          switch (value) {
                            case 'ledger':
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      CustomerLedgerScreen(customer: customer),
                                ),
                              );

                              break;

                            case 'edit':
                              showDialog(
                                context: context,

                                builder: (_) =>
                                    EditCustomerDialog(customer: customer),
                              );

                              break;

                            case 'delete':
                              await ref
                                  .read(customerRepositoryProvider)
                                  .deleteCustomer(customer.id);

                              break;
                          /*  case 'payment':
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    ReceivePaymentDialog(
                                      customer: customer,
                                    ),
                              );
                              break;

                            case 'history':
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    PaymentHistoryDialog(
                                      customer: customer,
                                    ),
                              );
                              break;*/
                          }
                        },

                          itemBuilder: (_) => [
                            /*const PopupMenuItem(
                              value: 'payment',
                              child: Row(
                                children: [
                                  Icon(Icons.payments),
                                  SizedBox(width: 10),
                                  Text('Receive Payment'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'history',
                              child: Row(
                                children: [
                                  Icon(Icons.history),
                                  SizedBox(width: 10),
                                  Text('Payment History'),
                                ],
                              ),
                            ),*/
                            const PopupMenuItem(
                              value: 'ledger',
                              child: Row(
                                children: [
                                  Icon(Icons.receipt_long),
                                  SizedBox(width: 10),
                                  Text('Ledger'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 10),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ]                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
