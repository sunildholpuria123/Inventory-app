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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: Text(
                  customer.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      customer.phone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),

                    if (customer.email != null)
                      Text(
                        customer.email!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Chip(
                backgroundColor: Colors.white,
                label: Text(
                  customer.creditBalance > 0 ? 'Credit' : 'Regular',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ActionButton(
                icon: Icons.chat,
                tooltip: 'WhatsApp',
                onTap: () async {
                  await WhatsAppHelper.openChat(
                    phone: customer.phone,
                    message: 'Hello ${customer.name}',
                  );
                },
              ),

              _ActionButton(
                icon: Icons.call,
                tooltip: 'Call',
                onTap: () async {
                  await WhatsAppHelper.openChat(
                    phone: customer.phone,
                    message: 'Hello ${customer.name}',
                  );
                },
              ),

              _ActionButton(icon: Icons.edit, tooltip: 'Edit', onTap: () {}),

              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
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
                  PopupMenuItem(
                    value: 'payment',
                    child: Text('Payment Reminder'),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.18),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}