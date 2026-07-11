import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/customer_followup_provider.dart';
import 'add_followup_dialog.dart';

class CustomerFollowUpsTab extends ConsumerWidget {
  final Customer customer;

  const CustomerFollowUpsTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followUps = ref.watch(customerFollowUpsProvider(customer.id));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Follow-up'),
        onPressed: () {
          showAddFollowUpDialog(context, ref, customer.id);
        },
      ),
      body: followUps.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No Follow-ups'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];

              final overdue =
                  !item.completed && item.followUpDate.isBefore(DateTime.now());

              return Card(
                child: CheckboxListTile(
                  value: item.completed,
                  onChanged: (value) async {
                    final repo = ref.read(customerFollowUpRepositoryProvider);

                    await repo.updateCompleted(id: item.id, completed: value!);
                  },
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.description != null) Text(item.description!),
                      const SizedBox(height: 6),
                      Text(
                        item.followUpDate.toString().substring(0, 16),
                        style: TextStyle(color: overdue ? Colors.red : null),
                      ),
                    ],
                  ),
                  secondary: overdue
                      ? const Icon(Icons.warning, color: Colors.red)
                      : const Icon(Icons.event),
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
