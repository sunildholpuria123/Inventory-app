import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_provider.dart';

class AddProductDialog
    extends ConsumerStatefulWidget {
  const AddProductDialog({super.key});

  @override
  ConsumerState<AddProductDialog>
  createState() =>
      _AddProductDialogState();
}

class _AddProductDialogState
    extends ConsumerState<AddProductDialog> {
  String? imagePath;
  final nameController =
  TextEditingController();

  final purchaseController =
  TextEditingController();

  final sellingController =
  TextEditingController();

  final stockController =
  TextEditingController();

  final formKey = GlobalKey<FormState>();

  final barcodeController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product'),

      content: SizedBox(
        width: 400,

        child: Form(
          key: formKey,

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextFormField(
                controller: nameController,

                decoration:
                const InputDecoration(
                  labelText: 'Product Name',
                ),

                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter product name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                purchaseController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText:
                  'Purchase Price',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                sellingController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText:
                  'Selling Price',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: stockController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText:
                  'Stock Quantity',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: barcodeController,
                decoration: const InputDecoration(
                  labelText: 'Barcode',
                ),
              ),
            ],
          ),
        ),
      ),

      actions: [
        ElevatedButton.icon(
          onPressed: () async {
            final result =
            await FilePicker.platform.pickFiles(
              type: FileType.image,
            );

            if (result != null) {
              imagePath =
                  result.files.single.path;
            }
          },
          icon: const Icon(Icons.image),
          label: const Text('Pick Image'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () async {
            if (!formKey.currentState!
                .validate()) {
              return;
            }

            final repo = ref.read(
              productRepositoryProvider,
            );

            await repo.addProduct(
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
            );

            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}