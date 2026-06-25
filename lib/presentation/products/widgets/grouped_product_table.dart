import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive_helper.dart';
import '../model/product_group.dart';
import '../provider/product_provider.dart';
import 'product_card_v2.dart';
import 'product_table.dart';

class GroupedProductTable extends ConsumerWidget {
  final List<ProductGroup> groups;

  const GroupedProductTable({super.key, required this.groups});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = ref.watch(expandedCategoriesProvider);

    return ListView.separated(
      itemCount: groups.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final group = groups[index];

        final isExpanded = expanded.contains(group.category.id);

        return Card(
          elevation: 0,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(isExpanded ? Icons.folder_open : Icons.folder),
                ),
                title: Text(group.category.name),
                subtitle: Text(
                  '${group.totalProducts} Products • ${group.totalStock.toStringAsFixed(0)} ${group.category.unit}',
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
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox(),
                secondChild: ProductTable(products: group.products),
              ),
            ],
          ),
        );
      },
    );
  }
}
