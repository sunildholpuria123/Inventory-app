import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/supplier_provider.dart';

class SupplierPaymentHistoryScreen extends ConsumerWidget {
  final Supplier supplier;

  const SupplierPaymentHistoryScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(supplierRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('${supplier.name} Payments')),

      body: StreamBuilder(
        stream: repo.watchSupplierPayments(supplier.id),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final payments = snapshot.data!;

          return ListView.builder(
            itemCount: payments.length,

            itemBuilder: (_, index) {
              final payment = payments[index];

              return ListTile(
                title: Text('Rs.${payment.amount}'),

                subtitle: Text(payment.paymentMethod),

                trailing: Text(payment.createdAt.toString().split(' ').first),
              );
            },
          );
        },
      ),
    );
  }
}
