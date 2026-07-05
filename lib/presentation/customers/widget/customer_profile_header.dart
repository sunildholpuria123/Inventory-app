import 'package:flutter/material.dart';

import '../../../core/utils/whatsapp_helper.dart';
import '../../../data/database/app_database.dart';

class CustomerProfileHeader extends StatelessWidget {
  final Customer customer;

  const CustomerProfileHeader({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff7C3AED)],
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Text(
              customer.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  customer.phone,
                  style: const TextStyle(color: Colors.white70),
                ),

                if (customer.email != null)
                  Text(
                    customer.email!,
                    style: const TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Chip(
                backgroundColor: Colors.white,
                label: Text(
                  customer.creditBalance > 0 ? 'Credit' : 'Regular',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      tooltip: 'WhatsApp',
                      icon: const Icon(Icons.chat, color: Colors.white),
                      onPressed: () async {
                        await WhatsAppHelper.openChat(
                          phone: customer.phone,
                          message: 'Hello ${customer.name}',
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      tooltip: 'Call',
                      icon: const Icon(Icons.call, color: Colors.white),
                      onPressed: () async {
                        await WhatsAppHelper.openChat(
                          phone: customer.phone,
                          message: 'Hello ${customer.name}',
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      tooltip: 'Edit',
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Open existing edit customer dialog
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.chat, color: Colors.white),
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
                            amount: customer.creditBalance,
                          );
                          break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'chat', child: Text('Open Chat')),
                      PopupMenuItem(value: 'payment', child: Text('Payment Reminder')),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
