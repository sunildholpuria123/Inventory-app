import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/supplier_provider.dart';
import '../widgets/add_supplier_dialog.dart';
import '../widgets/supplier_table.dart';

class SupplierScreen extends ConsumerWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliers = ref.watch(suppliersProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Suppliers',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                FilledButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AddSupplierDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Supplier'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Supplier',
                prefixIcon: Icon(Icons.search),
              ),

              onChanged: (value) {
                ref.read(supplierSearchProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: suppliers.when(
                data: (items) {
                  final search = ref.watch(supplierSearchProvider);

                  final filtered = items.where((e) {
                    return e.name.toLowerCase().contains(search.toLowerCase());
                  }).toList();

                  return SupplierTable(suppliers: filtered);
                },

                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text(e.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
