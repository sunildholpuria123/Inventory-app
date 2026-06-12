import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_provider.dart';

class EditCustomerDialog extends ConsumerStatefulWidget {
  final Customer customer;

  const EditCustomerDialog({super.key, required this.customer});

  @override
  ConsumerState<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends ConsumerState<EditCustomerDialog> {
  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;

  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.customer.name);

    phoneController = TextEditingController(text: widget.customer.phone);

    emailController = TextEditingController(text: widget.customer.email ?? '');

    addressController = TextEditingController(
      text: widget.customer.address ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Customer'),

      content: SizedBox(
        width: 400,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
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
          ],
        ),
      ),

      actions: [
        ElevatedButton(
          onPressed: () async {
            final repo = ref.read(customerRepositoryProvider);

            await repo.updateCustomerData(
              customer: widget.customer.copyWith(
                name: nameController.text,
                phone: phoneController.text,

                email: Value(emailController.text),

                address: Value(addressController.text),
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
