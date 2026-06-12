import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/product_image_service.dart';
import '../../../data/database/app_database.dart';
import '../../categories/provider/category_provider.dart';
import '../provider/product_provider.dart';

class EditProductDialog extends ConsumerStatefulWidget {
  final Product product;

  const EditProductDialog({super.key, required this.product});

  @override
  ConsumerState<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends ConsumerState<EditProductDialog> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;

  late final TextEditingController purchaseController;

  late final TextEditingController sellingController;

  late final TextEditingController stockController;

  String? selectedImagePath;

  bool isLoading = false;
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name);

    purchaseController = TextEditingController(
      text: widget.product.purchasePrice.toString(),
    );

    sellingController = TextEditingController(
      text: widget.product.sellingPrice.toString(),
    );

    stockController = TextEditingController(
      text: widget.product.stockQty.toString(),
    );

    selectedImagePath = widget.product.imagePath;
    selectedCategoryId = widget.product.categoryId;
  }

  @override
  void dispose() {
    nameController.dispose();

    purchaseController.dispose();

    sellingController.dispose();

    stockController.dispose();

    super.dispose();
  }

  /// PICK IMAGE
  Future<void> pickImage() async {
    final path = await ProductImageService.pickAndSaveImage();

    if (path != null) {
      /// DELETE OLD IMAGE
      if (selectedImagePath != null && selectedImagePath != path) {
        await ProductImageService.deleteImage(selectedImagePath);
      }

      setState(() {
        selectedImagePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    return AlertDialog(
      title: const Text('Edit Product'),

      content: SizedBox(
        width: 450,

        child: Form(
          key: formKey,

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                /// IMAGE
                Center(
                  child: GestureDetector(
                    onTap: pickImage,

                    child: Container(
                      width: 130,
                      height: 130,

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: selectedImagePath == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(Icons.add_a_photo, size: 40),

                                SizedBox(height: 10),

                                Text('Select Image'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),

                              child: Image.file(
                                File(selectedImagePath!),

                                fit: BoxFit.cover,

                                errorBuilder: (_, __, ___) {
                                  return const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Icon(Icons.broken_image, size: 40),

                                      SizedBox(height: 10),

                                      Text('Image Error'),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// PRODUCT NAME
                TextFormField(
                  controller: nameController,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter product name';
                    }

                    return null;
                  },

                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                const SizedBox(height: 20),

                categories.when(
                  data: (items) {
                    return DropdownButtonFormField<int>(
                      value: selectedCategoryId,

                      decoration: const InputDecoration(labelText: 'Category'),

                      items: items.map((category) {
                        return DropdownMenuItem(
                          value: category.id,

                          child: Text(category.name),
                        );
                      }).toList(),

                      validator: (value) {
                        if (value == null) {
                          return 'Select Category';
                        }

                        return null;
                      },

                      onChanged: (value) {
                        setState(() {
                          selectedCategoryId = value;
                        });
                      },
                    );
                  },

                  loading: () => const CircularProgressIndicator(),

                  error: (_, __) => const Text('Unable to load categories'),
                ),

                const SizedBox(height: 20),

                /// PURCHASE PRICE
                TextFormField(
                  controller: purchaseController,

                  keyboardType: TextInputType.number,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter purchase price';
                    }

                    return null;
                  },

                  decoration: const InputDecoration(
                    labelText: 'Purchase Price',
                  ),
                ),

                const SizedBox(height: 20),

                /// SELLING PRICE
                TextFormField(
                  controller: sellingController,

                  keyboardType: TextInputType.number,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter selling price';
                    }

                    return null;
                  },

                  decoration: const InputDecoration(labelText: 'Selling Price'),
                ),

                const SizedBox(height: 20),

                /// STOCK
                TextFormField(
                  controller: stockController,

                  keyboardType: TextInputType.number,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter stock quantity';
                    }

                    return null;
                  },

                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                  ),
                ),
              ],
            ),
          ),
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
          onPressed: isLoading
              ? null
              : () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  try {
                    final repo = ref.read(productRepositoryProvider);

                    await repo.updateProduct(
                      id: widget.product.id,
                      categoryId: selectedCategoryId!,

                      name: nameController.text.trim(),

                      purchasePrice: double.parse(purchaseController.text),

                      sellingPrice: double.parse(sellingController.text),

                      stockQty: int.parse(stockController.text),

                      imagePath: selectedImagePath,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product Updated Successfully'),
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
                        isLoading = false;
                      });
                    }
                  }
                },

          child: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,

                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Update'),
        ),
      ],
    );
  }
}
