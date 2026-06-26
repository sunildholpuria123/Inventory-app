import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_documents_provider.dart';

class CustomerDocumentsTab extends ConsumerWidget {
  final Customer customer;

  const CustomerDocumentsTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(customerDocumentsProvider(customer.id));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();

          if (result == null) {
            return;
          }

          final file = result.files.first;

          final repo = ref.read(customerDocumentsRepositoryProvider);

          await repo.addDocument(
            customerId: customer.id,
            name: file.name,
            filePath: file.path!,
          );
        },
      ),
      body: documents.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Documents'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final doc = items[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.insert_drive_file),
                  title: Text(doc.name),
                  subtitle: Text(doc.createdAt.toString().substring(0, 16)),
                  onTap: () async {
                    await OpenFilex.open(doc.filePath);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final repo = ref.read(
                        customerDocumentsRepositoryProvider,
                      );

                      await repo.deleteDocument(doc.id);
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
