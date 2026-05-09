import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_provider.dart';

class EditProductDialog
    extends ConsumerStatefulWidget {
  final Product product;

  const EditProductDialog({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<EditProductDialog>
  createState() =>
      _EditProductDialogState();
}

class _EditProductDialogState
    extends ConsumerState<EditProductDialog> {
  late TextEditingController nameController;

  late TextEditingController purchaseController;

  late TextEditingController sellingController;

  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
          text: widget.product.name,
        );

    purchaseController =
        TextEditingController(
          text: widget.product.purchasePrice
              .toString(),
        );

    sellingController =
        TextEditingController(
          text: widget.product.sellingPrice
              .toString(),
        );

    stockController =
        TextEditingController(
          text:
          widget.product.stockQty.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Product'),

      content: SizedBox(
        width: 400,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
              const InputDecoration(
                labelText: 'Product Name',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              purchaseController,
              decoration:
              const InputDecoration(
                labelText:
                'Purchase Price',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              sellingController,
              decoration:
              const InputDecoration(
                labelText:
                'Selling Price',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: stockController,
              decoration:
              const InputDecoration(
                labelText:
                'Stock Quantity',
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(
              productRepositoryProvider,
            );

            await repo.updateProductData(
              product:
              widget.product.copyWith(
                name: nameController.text,

                purchasePrice:
                double.parse(
                  purchaseController.text,
                ),

                sellingPrice:
                double.parse(
                  sellingController.text,
                ),

                stockQty: int.parse(
                  stockController.text,
                ),
              ),
            );

            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}