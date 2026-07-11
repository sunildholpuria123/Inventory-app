import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../categories/provider/category_provider.dart';
import '../../products/provider/product_provider.dart';
import '../../products/provider/product_variant_provider.dart';
import '../../products/widgets/variant_selection_dialog.dart';
import '../model/cart_item.dart';
import '../provider/sales_provider.dart';
import 'area_measurement_dialog.dart';

class ProductDropdown extends ConsumerStatefulWidget {
  const ProductDropdown({super.key});

  @override
  ConsumerState<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends ConsumerState<ProductDropdown> {
  int? selectedProductId;

  Future<void> _addProduct(Product product) async {
    double? height;
    double? width;

    final categoryRepo = ref.read(categoryRepositoryProvider);

    final category = await categoryRepo.getCategoryById(product.categoryId);

    if (category?.pricingType == 'AREA') {
      final measurement = await showDialog<AreaMeasurementResult>(
        context: context,

        builder: (_) => const AreaMeasurementDialog(),
      );

      if (measurement == null) {
        return;
      }

      height = measurement.height;

      width = measurement.width;
    }

    /// OUT OF STOCK CHECK
    if (product.stockQty <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Out of stock')));

      return;
    }

    final current = ref.read(invoiceItemsProvider);

    /// PREVENT DUPLICATES
    final exists = current.any((item) {
      return item.product.id == product.id;
    });

    if (exists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product already added')));

      return;
    }

    ProductVariant? selectedVariant;

    /// CHECK VARIANTS
    final variants = await ref
        .read(productVariantRepositoryProvider)
        .watchVariants(product.id)
        .first;

    if (variants.isNotEmpty) {
      selectedVariant = await showDialog<ProductVariant>(
        context: context,

        builder: (_) => VariantSelectionDialog(productId: product.id),
      );

      if (selectedVariant == null) {
        return;
      }

      /// VARIANT STOCK CHECK
      if (selectedVariant.stockQty <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Variant out of stock')));
        }

        return;
      }
    }

    ref.read(invoiceItemsProvider.notifier).state = [
      ...current,

      CartItem(
        product: product,

        variant: selectedVariant,

        quantity: 1,

        unitPrice: selectedVariant?.sellingPrice ?? product.sellingPrice,

        height: height,

        width: width,
      ),
    ];

    setState(() {
      selectedProductId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    return products.when(
      data: (items) {
        return DropdownButtonFormField<int>(
          value: selectedProductId,

          decoration: const InputDecoration(labelText: 'Add Product'),

          items: items.map((product) {
            return DropdownMenuItem(
              value: product.id,

              child: Text(product.name),
            );
          }).toList(),

          onChanged: (value) async {
            if (value == null) {
              return;
            }

            final product = items.firstWhere((e) => e.id == value);

            await _addProduct(product);
          },
        );
      },

      loading: () => const CircularProgressIndicator(),

      error: (e, _) => Text(e.toString()),
    );
  }
}
