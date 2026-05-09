import 'package:flutter/material.dart';

class PurchaseHistoryScreen
    extends StatelessWidget {
  const PurchaseHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Card(
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text('ID'),
              ),
              DataColumn(
                label:
                Text('Supplier'),
              ),
              DataColumn(
                label: Text('Date'),
              ),
              DataColumn(
                label: Text('Total'),
              ),
            ],

            rows: List.generate(
              10,
                  (index) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '#$index',
                      ),
                    ),

                    DataCell(
                      Text(
                        'Supplier $index',
                      ),
                    ),

                    DataCell(
                      Text(
                        '12 Aug 2025',
                      ),
                    ),

                    DataCell(
                      Text(
                        '₹2500',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}