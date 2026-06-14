import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/supplier_provider.dart';
import '../screens/supplier_ledger_screen.dart';

class SupplierTable extends ConsumerWidget {
  final List<Supplier> suppliers;

  const SupplierTable({super.key, required this.suppliers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),

            DataColumn(label: Text('Phone')),

            DataColumn(label: Text('GST')),

            DataColumn(label: Text('Balance')),

            DataColumn(label: Text('Actions')),
          ],

          rows: suppliers.map((s) {
            return DataRow(
              cells: [
                DataCell(Text(s.name)),

                DataCell(Text(s.phone)),

                DataCell(Text(s.email ?? '')),

                DataCell(Text('Rs.${s.creditBalance}')),

                DataCell(Text(s.gstNumber ?? '-')),

                DataCell(
                  Text(
                    'Rs.${s.creditBalance.toStringAsFixed(2)}',

                    style: TextStyle(
                      color: s.creditBalance > 0 ? Colors.red : Colors.green,
                    ),
                  ),
                ),

                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),

                      IconButton(
                        onPressed: () async {
                          final repo = ref.read(supplierRepositoryProvider);

                          await repo.deleteSupplier(s.id);
                        },

                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      IconButton(
                        icon: const Icon(Icons.history),

                        onPressed: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  SupplierLedgerScreen(supplier: s),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
