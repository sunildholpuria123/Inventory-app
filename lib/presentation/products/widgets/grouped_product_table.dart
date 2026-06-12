import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_group.dart';
import '../provider/product_provider.dart';
import 'product_table.dart';

class GroupedProductTable extends ConsumerWidget {
  final List<ProductGroup> groups;

  const GroupedProductTable({super.key, required this.groups});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = ref.watch(expandedCategoriesProvider);

    return ListView.builder(
      itemCount: groups.length,

      itemBuilder: (context, index) {
        final group = groups[index];

        final isExpanded = expanded.contains(group.category.id);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          child: Column(
            children: [
              ListTile(
                leading: Icon(isExpanded ? Icons.folder_open : Icons.folder),

                title: Text(group.category.name),

                subtitle: Text(
                  '${group.totalProducts} Products • '
                  '${group.totalStock.toStringAsFixed(0)} '
                  '${group.category.unit}',
                ),

                trailing: IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),

                  onPressed: () {
                    final notifier = ref.read(
                      expandedCategoriesProvider.notifier,
                    );

                    final current = {...notifier.state};

                    if (isExpanded) {
                      current.remove(group.category.id);
                    } else {
                      current.add(group.category.id);
                    }

                    notifier.state = current;
                  },
                ),
              ),

              if (isExpanded) ProductTable(products: group.products),
            ],
          ),
        );
      },
    );
  }
}
