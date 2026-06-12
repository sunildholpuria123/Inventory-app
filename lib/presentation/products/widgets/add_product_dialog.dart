import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/product_image_service.dart';
import '../provider/product_provider.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  const AddProductDialog({super.key});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  String? imagePath;

  final nameController = TextEditingController();

  final purchaseController = TextEditingController();

  final sellingController = TextEditingController();

  final stockController = TextEditingController();

  final barcodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isSaving = false;

  /// PICK + SAVE IMAGE
  Future<void> pickImage() async {
    final path = await ProductImageService.pickAndSaveImage();

    if (path != null) {
      setState(() {
        imagePath = path;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();

    purchaseController.dispose();

    sellingController.dispose();

    stockController.dispose();

    barcodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product'),

      content: SizedBox(
        width: 450,

        child: SingleChildScrollView(
          child: Form(
            key: formKey,

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                /// IMAGE PICKER
                Center(
                  child: GestureDetector(
                    onTap: pickImage,

                    child: Container(
                      width: 120,
                      height: 120,

                      decoration: BoxDecoration(
                        border: Border.all(),

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: imagePath == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(Icons.add_a_photo, size: 40),

                                SizedBox(height: 8),

                                Text('Pick Image'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),

                              child: Image.file(
                                File(imagePath!),

                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// PRODUCT NAME
                TextFormField(
                  controller: nameController,

                  decoration: const InputDecoration(labelText: 'Product Name'),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter product name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// PURCHASE PRICE
                TextFormField(
                  controller: purchaseController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Purchase Price',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter purchase price';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// SELLING PRICE
                TextFormField(
                  controller: sellingController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(labelText: 'Selling Price'),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter selling price';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// STOCK
                TextFormField(
                  controller: stockController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter stock quantity';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// BARCODE
                TextFormField(
                  controller: barcodeController,

                  decoration: const InputDecoration(labelText: 'Barcode'),
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: isSaving
              ? null
              : () {
                  Navigator.pop(context);
                },

          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: isSaving
              ? null
              : () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  try {
                    setState(() {
                      isSaving = true;
                    });

                    final repo = ref.read(productRepositoryProvider);

                    await repo.addProduct(
                      name: nameController.text.trim(),

                      purchasePrice: double.parse(purchaseController.text),

                      sellingPrice: double.parse(sellingController.text),

                      stockQty: int.parse(stockController.text),

                      imagePath: imagePath,
                    );

                    if (mounted) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product Added Successfully'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  } finally {
                    if (mounted) {
                      setState(() {
                        isSaving = false;
                      });
                    }
                  }
                },

          child: isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,

                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
