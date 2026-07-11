import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/product_variant_provider.dart';

class AddEditVariantDialog extends ConsumerStatefulWidget {
  final int productId;

  final ProductVariant? variant;

  const AddEditVariantDialog({
    super.key,
    required this.productId,
    this.variant,
  });

  @override
  ConsumerState<AddEditVariantDialog> createState() =>
      _AddEditVariantDialogState();
}

class _AddEditVariantDialogState extends ConsumerState<AddEditVariantDialog> {
  final nameController = TextEditingController();

  final thicknessController = TextEditingController();

  final colorController = TextEditingController();

  final sizeController = TextEditingController();

  final purchaseController = TextEditingController();

  final sellingController = TextEditingController();

  final stockController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final variant = widget.variant;

    if (variant != null) {
      nameController.text = variant.variantName;

      thicknessController.text = variant.thickness ?? '';

      colorController.text = variant.color ?? '';

      sizeController.text = variant.size ?? '';

      purchaseController.text = variant.purchasePrice.toString();

      sellingController.text = variant.sellingPrice.toString();

      stockController.text = variant.stockQty.toString();
    }
  }

  Future<void> save() async {
    final repo = ref.read(productVariantRepositoryProvider);

    if (widget.variant == null) {
      await repo.addVariant(
        ProductVariantsCompanion.insert(
          productId: widget.productId,

          variantName: nameController.text,

          purchasePrice: double.parse(purchaseController.text),

          sellingPrice: double.parse(sellingController.text),

          stockQty: double.parse(stockController.text),

          thickness: Value(
            thicknessController.text.isEmpty ? null : thicknessController.text,
          ),

          color: Value(
            colorController.text.isEmpty ? null : colorController.text,
          ),

          size: Value(sizeController.text.isEmpty ? null : sizeController.text),
        ),
      );
    } else {
      await repo.updateVariant(
        widget.variant!.copyWith(
          variantName: nameController.text,

          purchasePrice: double.parse(purchaseController.text),

          sellingPrice: double.parse(sellingController.text),

          stockQty: double.parse(stockController.text),

          thickness: Value(
            thicknessController.text.isEmpty ? null : thicknessController.text,
          ),

          color: Value(
            colorController.text.isEmpty ? null : colorController.text,
          ),

          size: Value(sizeController.text.isEmpty ? null : sizeController.text),
        ),
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.variant == null ? 'Add Variant' : 'Edit Variant'),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TextField(
              controller: nameController,

              decoration: const InputDecoration(labelText: 'Variant Name'),
            ),

            TextField(
              controller: thicknessController,

              decoration: const InputDecoration(labelText: 'Thickness'),
            ),

            TextField(
              controller: colorController,

              decoration: const InputDecoration(labelText: 'Color'),
            ),

            TextField(
              controller: sizeController,

              decoration: const InputDecoration(labelText: 'Size'),
            ),

            TextField(
              controller: purchaseController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Purchase Price'),
            ),

            TextField(
              controller: sellingController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Selling Price'),
            ),

            TextField(
              controller: stockController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Stock'),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),

          child: const Text('Cancel'),
        ),

        ElevatedButton(onPressed: save, child: const Text('Save')),
      ],
    );
  }
}
