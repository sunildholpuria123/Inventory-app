import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/provider/product_provider.dart';
import '../../products/provider/product_variant_provider.dart';
import '../../suppliers/provider/supplier_provider.dart';
import '../provider/purchase_provider.dart';
import '../widgets/purchase_item_list.dart';
import '../widgets/purchase_product_dropdown.dart';
import '../widgets/purchase_summary.dart';
import '../../suppliers/widgets/supplier_dropdown.dart';

class PurchaseScreen extends ConsumerStatefulWidget {
  const PurchaseScreen({super.key});

  @override
  ConsumerState<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends ConsumerState<PurchaseScreen> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
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
                  onPressed: isSaving
                      ? null
                      : () async {
                          final supplier = ref.read(selectedSupplierProvider);

                          final items = ref.read(purchaseItemsProvider);

                          final total = ref.read(purchaseSubtotalProvider);

                          /// VALIDATION
                          if (supplier == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Select Supplier')),
                            );

                            return;
                          }

                          if (items.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Add Products')),
                            );

                            return;
                          }

                          try {
                            setState(() {
                              isSaving = true;
                            });

                            final repo = ref.read(purchaseRepositoryProvider);

                            /// SAVE PURCHASE
                            final purchaseId = await repo.savePurchase(
                              supplierName: supplier.name,

                              supplierPhone: supplier.phone ?? '',

                              total: total,
                            );

                            /// SAVE PURCHASE ITEMS
                            await repo.savePurchaseItems(
                              purchaseId: purchaseId,

                              items: items,
                            );

                            final supplierRepo = ref.read(
                              supplierRepositoryProvider,
                            );

                            await supplierRepo.updateCreditBalance(
                              supplierId: supplier.id,

                              amount: total,
                            );

                            /// UPDATE STOCK
                            final productRepo = ref.read(
                              productRepositoryProvider,
                            );

                            final variantRepo = ref.read(
                              productVariantRepositoryProvider,
                            );

                            for (final item in items) {
                              if (item.variant != null) {
                                await variantRepo.updateVariant(
                                  item.variant!.copyWith(
                                    stockQty: item.variant!.stockQty + item.qty,
                                  ),
                                );
                              } else {
                                await productRepo.increaseStock(
                                  productId: item.product.id,

                                  qty: item.qty,
                                );
                              }
                            }

                            /// CLEAR CART
                            ref.read(purchaseItemsProvider.notifier).state = [];

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Purchase Saved Successfully'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                isSaving = false;
                              });
                            }
                          }
                        },

                  icon: isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,

                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),

                  label: Text(isSaving ? 'Saving...' : 'Save Purchase'),
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
