import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/customer_credit_provider.dart';
import '../screen/due_payments_screen.dart';
import 'customer_kpi_card.dart';

class CustomerCreditDashboard extends ConsumerWidget {
  const CustomerCreditDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credit = ref.watch(customerCreditProvider);

    return credit.when(
      data: (data) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: CustomerKpiCard(
                    title: 'Total Due',
                    value: '₹${data.totalDue.toStringAsFixed(0)}',
                    icon: Icons.account_balance_wallet,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DuePaymentsScreen(),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: CustomerKpiCard(
                    title: 'Due Customers',
                    value: '${data.customersWithDue}',
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DuePaymentsScreen(),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: CustomerKpiCard(
                    title: 'Average Due',
                    value: '₹${data.averageDue.toStringAsFixed(0)}',
                    icon: Icons.trending_up,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DuePaymentsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      loading: () => const SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}