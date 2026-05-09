import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/customer_provider.dart';

class AddCustomerDialog
    extends ConsumerStatefulWidget {
  const AddCustomerDialog({
    super.key,
  });

  @override
  ConsumerState<AddCustomerDialog>
  createState() =>
      _AddCustomerDialogState();
}

class _AddCustomerDialogState
    extends ConsumerState<AddCustomerDialog> {
  final nameController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final addressController =
  TextEditingController();

  final formKey =
  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Customer',
      ),

      content: SizedBox(
        width: 400,

        child: Form(
          key: formKey,

          child: Column(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              TextFormField(
                controller:
                nameController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Customer Name',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                phoneController,
                decoration:
                const InputDecoration(
                  labelText: 'Phone',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                emailController,
                decoration:
                const InputDecoration(
                  labelText: 'Email',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
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
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
          ),
        ),

        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(
              customerRepositoryProvider,
            );

            await repo.addCustomer(
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