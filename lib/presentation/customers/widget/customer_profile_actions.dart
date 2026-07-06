import 'package:flutter/material.dart';

class CustomerProfileActions extends StatelessWidget {
  final VoidCallback onReceivePayment;
  final VoidCallback onLedger;
  final VoidCallback onWhatsapp;
  final VoidCallback onEdit;

  const CustomerProfileActions({
    super.key,
    required this.onReceivePayment,
    required this.onLedger,
    required this.onWhatsapp,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _ActionButton(
            icon: Icons.payments_rounded,
            label: 'Receive',
            color: Colors.green,
            onTap: onReceivePayment,
          ),
          _ActionButton(
            icon: Icons.receipt_long_rounded,
            label: 'Ledger',
            color: Colors.blue,
            onTap: onLedger,
          ),
          _ActionButton(
            icon: Icons.chat_rounded,
            label: 'WhatsApp',
            color: Colors.teal,
            onTap: onWhatsapp,
          ),
          _ActionButton(
            icon: Icons.edit_rounded,
            label: 'Edit',
            color: Colors.orange,
            onTap: onEdit,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 56) / 2;

    return SizedBox(
      width: width,
      height: 54,
      child: FilledButton.icon(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}