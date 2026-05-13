import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/purchase_repository_provider.dart';

class PurchaseHistoryScreen
    extends ConsumerWidget {
  const PurchaseHistoryScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final repo = ref.watch(
      purchaseRepositoryProvider,
    );

    return FutureBuilder(
      future: repo.getPurchases(),

      builder: (
          context,
          snapshot,
          ) {
        if (!snapshot.hasData) {
          return const Center(
            child:
            CircularProgressIndicator(),
          );
        }

        final purchases =
        snapshot.data!;

        if (purchases.isEmpty) {
          return const Center(
            child: Text(
              'No Purchases Found',
            ),
          );
        }

        return ListView.builder(
          itemCount:
          purchases.length,

          itemBuilder: (
              context,
              index,
              ) {
            final purchase =
            purchases[index];

            return Card(
              child: ListTile(
                leading:
                const CircleAvatar(
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                ),

                title: Text(
                  purchase
                      .supplierName,
                ),

                subtitle: Text(
                  purchase
                      .purchaseNo,
                ),

                trailing: Row(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    Text(
                      '₹${purchase.total.toStringAsFixed(0)}',
                    ),

                    IconButton(
                      onPressed:
                          () async {
                        await repo
                            .deletePurchase(
                          purchase.id,
                        );
                      },

                      icon:
                      const Icon(
                        Icons.delete,

                        color:
                        Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}