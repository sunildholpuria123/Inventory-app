import 'package:flutter/material.dart' show BuildContext, Widget, SizedBox, Card, Colors, Icon, Icons, Text, Navigator, MaterialPageRoute, ListTile;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget, WidgetRef, AsyncValueX;

import '../../customers/screen/due_payments_screen.dart' show DuePaymentsScreen;
import '../provider/dashboard_stats_provider.dart' show overdueInvoicesProvider;

class DuePaymentAlertWidget extends ConsumerWidget {
  const DuePaymentAlertWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueInvoicesProvider);

    return overdue.when(
      data: (items) {
        if (items.isEmpty) {
          return const SizedBox();
        }

        return Card(
          color: Colors.red.shade50,

          child: ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),

            title: Text('${items.length} Overdue Payments'),

            subtitle: Text(
              '₹${items.fold(0.0, (sum, e) => sum + e.dueAmount)}',
            ),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const DuePaymentsScreen()),
              );
            },
          ),
        );
      },

      loading: () => const SizedBox(),

      error: (_, __) => const SizedBox(),
    );
  }
}
