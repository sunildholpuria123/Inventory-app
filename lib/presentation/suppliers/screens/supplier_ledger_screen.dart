import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../purchases/provider/purchase_provider.dart';
import '../../purchases/widgets/purchase_detail_dialog.dart';
import '../provider/supplier_provider.dart';

class SupplierLedgerScreen extends ConsumerWidget {
  final Supplier supplier;

  const SupplierLedgerScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(
      supplierRepositoryProvider,
    );

    final purchaseRepo = ref.watch(
      purchaseRepositoryProvider,
    );
    return Scaffold(
      appBar: AppBar(title: Text('${supplier.name} Ledger')),

      body: StreamBuilder<List<Purchase>>(
        stream: repo.watchSupplierPurchases(supplier.name),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final purchases = snapshot.data!;

          final totalPurchases = purchases.fold(
            0.0,
            (sum, purchase) => sum + purchase.total,
          );

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        supplier.name,

                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Phone: '
                        '${supplier.phone}',
                      ),

                      if (supplier.gstNumber != null)
                        Text(
                          'GST: '
                          '${supplier.gstNumber}',
                        ),

                      const SizedBox(height: 12),

                      Text(
                        'Outstanding: '
                        'Rs.${supplier.creditBalance.toStringAsFixed(2)}',

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,

                          color: Colors.red,
                        ),
                      ),

                      Text(
                        'Total Purchases: '
                        'Rs.${totalPurchases.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: purchases.isEmpty
                    ? const Center(child: Text('No Purchases'))
                    : ListView.builder(
                        itemCount: purchases.length,

                        itemBuilder: (context, index) {
                          final purchase = purchases[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,

                              vertical: 6,
                            ),

                            child: ListTile(
                              title: Text(purchase.purchaseNo),

                              subtitle: Text(
                                purchase.createdAt.toString().split(' ').first,
                              ),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Text(
                                    'Rs.${purchase.total.toStringAsFixed(0)}',

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.visibility),

                                    onPressed: () async {
                                      final items = await purchaseRepo.getPurchaseItems(
                                        purchase.id,
                                      );

                                      if (context.mounted) {
                                        showDialog(
                                          context: context,

                                          builder: (_) =>
                                              PurchaseDetailDialog(
                                                items: items,
                                              ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
