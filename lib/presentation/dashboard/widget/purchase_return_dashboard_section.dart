import 'package:flutter/material.dart';

import 'pending_refunds_card.dart';
import 'purchase_returns_card.dart';

class PurchaseReturnDashboardSection extends StatelessWidget {
  const PurchaseReturnDashboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,

      runSpacing: 16,

      children: const [
        PurchaseReturnsCard(),

        PendingRefundsCard(),
      ],
    );
  }
}