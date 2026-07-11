import 'package:flutter/material.dart'
    show
        BuildContext,
        Widget,
        SizedBox,
        Card,
        Colors,
        Icon,
        Icons,
        Text,
        Navigator,
        MaterialPageRoute,
        ListTile;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef, AsyncValueX;

import '../../customers/screen/due_payments_screen.dart' show DuePaymentsScreen;
import '../provider/dashboard_stats_provider.dart' show overdueInvoicesProvider, upcomingDueProvider;

class DuePaymentAlertWidget extends ConsumerWidget {
  const DuePaymentAlertWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueInvoicesProvider);

    final upcoming = ref.watch(upcomingDueProvider);
    return overdue.when(
      data: (overdueItems) {
        return upcoming.when(
          data: (upcomingItems) {
            final totalItems = [...overdueItems, ...upcomingItems];

            if (totalItems.isEmpty) {
              return const SizedBox();
            }

            final totalAmount = totalItems.fold(
              0.0,
              (sum, e) => sum + e.dueAmount,
            );

            return Card(
              color: overdueItems.isNotEmpty
                  ? Colors.red.shade50
                  : Colors.orange.shade50,

              child: ListTile(
                leading: Icon(
                  Icons.warning,

                  color: overdueItems.isNotEmpty ? Colors.red : Colors.orange,
                ),

                title: Text(
                  overdueItems.isNotEmpty
                      ? '${overdueItems.length} Overdue Payments'
                      : '${upcomingItems.length} Upcoming Payments',
                ),

                subtitle: Text('Rs.${totalAmount.toStringAsFixed(2)}'),

                trailing: const Icon(Icons.chevron_right),

                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => const DuePaymentsScreen(),
                    ),
                  );
                },
              ),
            );
          },

          loading: () => const SizedBox(),

          error: (_, __) => const SizedBox(),
        );
      },

      loading: () => const SizedBox(),

      error: (_, __) => const SizedBox(),
    );
  }
}
