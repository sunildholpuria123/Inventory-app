import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/category_provider.dart';

class AddEditCategoryDialog extends ConsumerStatefulWidget {
  final Category? category;

  const AddEditCategoryDialog({super.key, this.category});

  @override
  ConsumerState<AddEditCategoryDialog> createState() =>
      _AddEditCategoryDialogState();
}

class _AddEditCategoryDialogState extends ConsumerState<AddEditCategoryDialog> {
  final nameController = TextEditingController();

  String pricingType = 'QUANTITY';

  String unit = 'PCS';

  @override
  void initState() {
    super.initState();

    final category = widget.category;

    if (category != null) {
      nameController.text = category.name;

      pricingType = category.pricingType;

      unit = category.unit;
    }
  }

  Future<void> save() async {
    final repo = ref.read(categoryRepositoryProvider);

    if (widget.category == null) {
      await repo.addCategory(
        CategoriesCompanion.insert(
          name: nameController.text,

          pricingType: pricingType,

          unit: unit,
        ),
      );
    } else {
      await repo.updateCategory(
        widget.category!.copyWith(
          name: nameController.text,

          pricingType: pricingType,

          unit: unit,
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
      title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TextField(
              controller: nameController,

              decoration: const InputDecoration(labelText: 'Category Name'),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: pricingType,

              decoration: const InputDecoration(labelText: 'Pricing Type'),

              items: const [
                DropdownMenuItem(value: 'AREA', child: Text('AREA')),

                DropdownMenuItem(value: 'QUANTITY', child: Text('QUANTITY')),
              ],

              onChanged: (v) {
                setState(() {
                  pricingType = v!;
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: TextEditingController(text: unit),

              decoration: const InputDecoration(labelText: 'Unit'),

              onChanged: (v) {
                unit = v;
              },
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

        ElevatedButton(onPressed: save, child: const Text('Save')),
      ],
    );
  }
}
