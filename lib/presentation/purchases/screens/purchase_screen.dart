import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart'
    show productRepositoryProvider;
import '../provider/purchase_provider.dart';
import '../widgets/purchase_item_list.dart';
import '../widgets/purchase_product_dropdown.dart';
import '../widgets/purchase_summary.dart';
import '../widgets/supplier_dropdown.dart';

class PurchaseScreen extends ConsumerWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Purchase Entry',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    final supplier = ref.read(selectedSupplierProvider);

                    final item = ref.read(purchaseItemsProvider);

                    final total = ref.read(purchaseSubtotalProvider);

                    if (supplier == null || item.isEmpty) {
                      return;
                    }

                    final repo = ref.read(purchaseRepositoryProvider);

                    /// SAVE PURCHASE
                    await repo.savePurchase(
                      supplierId: supplier.id,

                      items: item,

                      total: total,
                    );

                    /// UPDATE PRODUCT STOCK
                    final productRepo = ref.read(productRepositoryProvider);

                    for (final purchaseItem in item) {
                      await productRepo.increaseStock(
                        productId: purchaseItem.product.id,

                        qty: purchaseItem.qty,
                      );
                    }

                    /// CLEAR CART
                    ref.read(purchaseItemsProvider.notifier).state = [];

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchase Saved')),
                      );
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save Purchase'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Expanded(child: SupplierDropdown()),

                SizedBox(width: 20),

                Expanded(child: PurchaseProductDropdown()),
              ],
            ),

            const SizedBox(height: 20),

            const Expanded(child: PurchaseItemList()),

            const SizedBox(height: 20),

            const PurchaseSummary(),
          ],
        ),
      ),
    );
  }
}
