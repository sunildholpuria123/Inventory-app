import 'package:flutter/material.dart';

import '../model/sync_table.dart';

class SyncTableSelector extends StatefulWidget {
  final Set<SyncTable> selectedTables;
  final ValueChanged<Set<SyncTable>> onChanged;

  const SyncTableSelector({
    super.key,
    required this.selectedTables,
    required this.onChanged,
  });

  @override
  State<SyncTableSelector> createState() =>
      _SyncTableSelectorState();
}

class _SyncTableSelectorState
    extends State<SyncTableSelector> {
  late Set<SyncTable> selected;

  @override
  void initState() {
    super.initState();
    selected = {...widget.selectedTables};
  }

  @override
  Widget build(BuildContext context) {
    final modules = [
      _SyncModule(
        SyncTable.customers,
        Icons.people,
        Colors.blue,
        'Customers',
        'Customer master data',
      ),

      _SyncModule(
        SyncTable.suppliers,
        Icons.local_shipping,
        Colors.orange,
        'Suppliers',
        'Supplier information',
      ),

      _SyncModule(
        SyncTable.products,
        Icons.inventory_2,
        Colors.green,
        'Products',
        'Inventory & Products',
      ),

      _SyncModule(
        SyncTable.invoices,
        Icons.receipt_long,
        Colors.deepPurple,
        'Invoices',
        'Sales invoices',
      ),

      _SyncModule(
        SyncTable.invoiceItems,
        Icons.shopping_cart,
        Colors.indigo,
        'Invoice Items',
        'Invoice products',
      ),

      _SyncModule(
        SyncTable.payments,
        Icons.payments,
        Colors.teal,
        'Payments',
        'Payment history',
      ),

      _SyncModule(
        SyncTable.expenses,
        Icons.account_balance_wallet,
        Colors.red,
        'Expenses',
        'Business expenses',
      ),
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Select Modules',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Choose the data you want to synchronize.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),

            const SizedBox(height: 24),

            LayoutBuilder(
              builder: (_, constraints) {
                final columns =
                constraints.maxWidth > 800 ? 2 : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: modules.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: 3.4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (_, index) {
                    final module = modules[index];

                    final checked =
                    selected.contains(module.table);

                    return InkWell(
                      borderRadius:
                      BorderRadius.circular(18),
                      onTap: () {
                        setState(() {
                          if (checked) {
                            selected.remove(module.table);
                          } else {
                            selected.add(module.table);
                          }
                        });

                        widget.onChanged(selected);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),
                        padding:
                        const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(18),
                          border: Border.all(
                            color: checked
                                ? module.color
                                : Colors.grey.shade300,
                            width: checked ? 2 : 1,
                          ),
                          color: checked
                              ? module.color.withOpacity(.08)
                              : null,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: module.color
                                  .withOpacity(.15),
                              child: Icon(
                                module.icon,
                                color: module.color,
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    module.title,
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 4),

                                  Text(
                                    module.subtitle,
                                    style:
                                    Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),

                            Checkbox(
                              value: checked,
                              onChanged: (_) {
                                setState(() {
                                  if (checked) {
                                    selected.remove(
                                        module.table);
                                  } else {
                                    selected.add(
                                        module.table);
                                  }
                                });

                                widget.onChanged(
                                    selected);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SyncModule {
  final SyncTable table;
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _SyncModule(
      this.table,
      this.icon,
      this.color,
      this.title,
      this.subtitle,
      );
}