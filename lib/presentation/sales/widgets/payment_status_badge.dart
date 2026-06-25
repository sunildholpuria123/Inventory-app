import 'package:flutter/material.dart';

class PaymentStatusBadge
    extends StatelessWidget {
  final String status;

  const PaymentStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    Color color =
        Colors.green;

    if (status == 'Partial') {
      color = Colors.orange;
    }

    if (status == 'Pending') {
      color = Colors.red;
    }

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color:
        color.withOpacity(
          .15,
        ),
        borderRadius:
        BorderRadius.circular(
          20,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}