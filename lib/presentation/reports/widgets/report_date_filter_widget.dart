import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/report_filter_model.dart';
import '../provider/report_filter_provider.dart';

class ReportDateFilterWidget extends ConsumerWidget {
  const ReportDateFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reportFilterProvider);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report Period',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Select a date range for analytics',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    final today = DateTime.now();

                    ref
                        .read(reportFilterProvider.notifier)
                        .state = ReportFilterModel(
                      startDate: DateTime(today.year, today.month, today.day),
                      endDate: today,
                    );
                  },
                  child: const Text('Today'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    final now = DateTime.now();

                    ref
                        .read(reportFilterProvider.notifier)
                        .state = ReportFilterModel(
                      startDate: DateTime(now.year, now.month, 1),
                      endDate: now,
                    );
                  },
                  child: const Text('This Month'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    final now = DateTime.now();

                    ref
                        .read(reportFilterProvider.notifier)
                        .state = ReportFilterModel(
                      startDate: DateTime(now.year, 1, 1),
                      endDate: now,
                    );
                  },
                  child: const Text('This Year'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      filter.startDate == null
                          ? 'Start Date'
                          : _formatDate(filter.startDate!),
                    ),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        initialDate: filter.startDate ?? DateTime.now(),
                      );

                      if (date == null) return;

                      ref
                          .read(reportFilterProvider.notifier)
                          .state = ReportFilterModel(
                        startDate: date,
                        endDate: filter.endDate,
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.event),
                    label: Text(
                      filter.endDate == null
                          ? 'End Date'
                          : _formatDate(filter.endDate!),
                    ),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        initialDate: filter.endDate ?? DateTime.now(),
                      );

                      if (date == null) return;

                      ref
                          .read(reportFilterProvider.notifier)
                          .state = ReportFilterModel(
                        startDate: filter.startDate,
                        endDate: date,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
