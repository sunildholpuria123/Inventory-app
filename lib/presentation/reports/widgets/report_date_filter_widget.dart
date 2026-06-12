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
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,

                  firstDate: DateTime(2020),

                  lastDate: DateTime.now(),

                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  ref
                      .read(reportFilterProvider.notifier)
                      .state = ReportFilterModel(
                    startDate: date,

                    endDate: filter.endDate,
                  );
                }
              },

              child: Text(
                filter.startDate == null
                    ? 'Start Date'
                    : filter.startDate.toString().split(' ').first,
              ),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,

                  firstDate: DateTime(2020),

                  lastDate: DateTime.now(),

                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  ref
                      .read(reportFilterProvider.notifier)
                      .state = ReportFilterModel(
                    startDate: filter.startDate,

                    endDate: date,
                  );
                }
              },

              child: Text(
                filter.endDate == null
                    ? 'End Date'
                    : filter.endDate.toString().split(' ').first,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
