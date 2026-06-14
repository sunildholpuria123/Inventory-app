import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/payment_history_provider.dart';

class PaymentHistoryDialog extends ConsumerWidget {
  final int invoiceId;

  const PaymentHistoryDialog({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(paymentHistoryProvider(invoiceId));

    return AlertDialog(
      title: const Text('Payment History'),

      content: SizedBox(
        width: 400,
        height: 300,

        child: history.when(
          data: (payments) {
            if (payments.isEmpty) {
              return const Center(child: Text('No Payments'));
            }

            return ListView.builder(
              itemCount: payments.length,

              itemBuilder: (context, index) {
                final payment = payments[index];

                return ListTile(
                  leading: const Icon(Icons.payments),

                  title: Text('Rs.${payment.amount}'),

                  subtitle: Text(payment.paidAt.toString()),

                  trailing: Text(payment.paymentMethod),
                );
              },
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Center(child: Text(e.toString())),
        ),
      ),
    );
  }
}
