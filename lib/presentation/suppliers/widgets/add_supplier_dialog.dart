import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_provider.dart';

class AddSupplierDialog
    extends ConsumerStatefulWidget {
  const AddSupplierDialog({
    super.key,
  });

  @override
  ConsumerState<AddSupplierDialog>
  createState() =>
      _AddSupplierDialogState();
}

class _AddSupplierDialogState
    extends ConsumerState<
        AddSupplierDialog> {
  final nameController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final addressController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Supplier',
      ),

      content: SizedBox(
        width: 400,

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            TextField(
              controller:
              nameController,

              decoration:
              const InputDecoration(
                labelText:
                'Supplier Name',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              phoneController,

              decoration:
              const InputDecoration(
                labelText: 'Phone',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              emailController,

              decoration:
              const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              addressController,

              decoration:
              const InputDecoration(
                labelText:
                'Address',
              ),
            ),
          ],
        ),
      ),

      actions: [
        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(
              supplierRepositoryProvider,
            );

            await repo.addSupplier(
              name:
              nameController.text,
              phone:
              phoneController.text,
              email:
              emailController.text,
              address:
              addressController.text,
            );

            if (mounted) {
              Navigator.pop(context);
            }
          },

          child: const Text(
            'Save',
          ),
        ),
      ],
    );
  }
}