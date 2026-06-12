import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../provider/purchase_provider.dart';

class SupplierDropdown extends ConsumerWidget {
  const SupplierDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    return FutureBuilder(
      future: db.select(db.suppliers).get(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final suppliers = snapshot.data!;

        return DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'Select Supplier'),

          items: suppliers.map((supplier) {
            return DropdownMenuItem(
              value: supplier,

              child: Text(supplier.name),
            );
          }).toList(),

          onChanged: (value) {
            ref.read(selectedSupplierProvider.notifier).state = value;
          },
        );
      },
    );
  }
}
