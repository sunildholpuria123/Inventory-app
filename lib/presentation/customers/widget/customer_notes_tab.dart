import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_notes_provider.dart';

class CustomerNotesTab extends ConsumerWidget {
  final Customer customer;

  const CustomerNotesTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(customerNotesProvider(customer.id));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context, ref);
        },
      ),
      body: notes.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Notes'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final note = items[index];

              return Card(
                child: ListTile(
                  title: Text(note.note),
                  subtitle: Text(note.createdAt.toString().substring(0, 16)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final repo = ref.read(customerNotesRepositoryProvider);

                      await repo.deleteNote(note.id);
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

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(hintText: 'Enter note'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) {
                return;
              }

              final repo = ref.read(customerNotesRepositoryProvider);

              await repo.addNote(
                customerId: customer.id,
                note: controller.text,
              );

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
