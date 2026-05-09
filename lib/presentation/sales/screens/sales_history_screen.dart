import 'package:flutter/material.dart';

import '../widgets/sales_analytics_card.dart';

class SalesHistoryScreen
    extends StatelessWidget {
  const SalesHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text(
                  'Sales History',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),

                SizedBox(
                  width: 300,

                  child: TextField(
                    decoration:
                    const InputDecoration(
                      hintText:
                      'Search Invoice',
                      prefixIcon:
                      Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Row(
              children: [
                SalesAnalyticsCard(
                  title: 'Today Sales',
                  value: '₹25,000',
                ),

                SizedBox(width: 20),

                SalesAnalyticsCard(
                  title: 'Invoices',
                  value: '15',
                ),

                SizedBox(width: 20),

                SalesAnalyticsCard(
                  title: 'Pending',
                  value: '₹5,000',
                ),
              ],
            ),
            Expanded(
              child: Card(
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label:
                      Text('Invoice'),
                    ),
                    DataColumn(
                      label:
                      Text('Customer'),
                    ),
                    DataColumn(
                      label:
                      Text('Date'),
                    ),
                    DataColumn(
                      label:
                      Text('Total'),
                    ),
                    DataColumn(
                      label:
                      Text('Status'),
                    ),
                  ],

                  rows: List.generate(
                    10,
                        (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'INV-100$index',
                            ),
                          ),

                          DataCell(
                            Text(
                              'Customer $index',
                            ),
                          ),

                          DataCell(
                            Text(
                              '12 Aug 2025',
                            ),
                          ),

                          DataCell(
                            Text(
                              '₹5000',
                            ),
                          ),

                          DataCell(
                            Chip(
                              label: Text(
                                'PAID',
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}