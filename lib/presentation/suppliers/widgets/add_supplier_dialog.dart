import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_provider.dart';

class AddSupplierDialog extends ConsumerStatefulWidget {
  const AddSupplierDialog({super.key});

  @override
  ConsumerState<AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends ConsumerState<AddSupplierDialog> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  final addressController = TextEditingController();
  final gstController = TextEditingController();

  final balanceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();

    phoneController.dispose();

    emailController.dispose();

    addressController.dispose();

    gstController.dispose();

    balanceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Supplier'),

      content: SizedBox(
        width: 400,

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TextField(
              controller: nameController,

              decoration: const InputDecoration(labelText: 'Supplier Name'),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,

              decoration: const InputDecoration(labelText: 'Phone'),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,

              decoration: const InputDecoration(labelText: 'Email'),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: addressController,

              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: gstController,

              decoration: const InputDecoration(labelText: 'GST Number'),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: balanceController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Opening Balance'),
            ),
          ],
        ),
      ),

      actions: [
        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(supplierRepositoryProvider);

            await repo.addSupplier(
              name: nameController.text,

              phone: phoneController.text,

              email: emailController.text.trim().isEmpty
                  ? null
                  : emailController.text,

              address: addressController.text.trim().isEmpty
                  ? null
                  : addressController.text,

              gstNumber: gstController.text.trim().isEmpty
                  ? null
                  : gstController.text,

              creditBalance: double.tryParse(balanceController.text) ?? 0,
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
