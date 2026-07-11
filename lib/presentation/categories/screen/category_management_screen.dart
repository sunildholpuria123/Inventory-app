import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/category_provider.dart';
import '../widgets/add_edit_category_dialog.dart';

class CategoryManagementScreen extends ConsumerWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(filteredCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,

            builder: (_) => const AddEditCategoryDialog(),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),

                labelText: 'Search Category',
              ),

              onChanged: (value) {
                ref.read(categorySearchProvider.notifier).state = value;
              },
            ),
          ),

          Expanded(
            child: categories.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No Categories'));
                }

                return ListView.builder(
                  itemCount: items.length,

                  itemBuilder: (context, index) {
                    final category = items[index];

                    return ListTile(
                      title: Text(category.name),

                      subtitle: Text(
                        '${category.pricingType} • ${category.unit}',
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),

                            onPressed: () {
                              showDialog(
                                context: context,

                                builder: (_) =>
                                    AddEditCategoryDialog(category: category),
                              );
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),

                            onPressed: () async {
                              await ref
                                  .read(categoryRepositoryProvider)
                                  .deleteCategory(category.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },

              loading: () => const Center(child: CircularProgressIndicator()),

              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
