import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/report_provider.dart';

class ReportFilter
    extends ConsumerWidget {
  const ReportFilter({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final selected = ref.watch(
      selectedReportFilterProvider,
    );

    return DropdownButton<String>(
      value: selected,

      items: const [
        DropdownMenuItem(
          value: 'Daily',
          child: Text('Daily'),
        ),

        DropdownMenuItem(
          value: 'Weekly',
          child: Text('Weekly'),
        ),

        DropdownMenuItem(
          value: 'Monthly',
          child: Text('Monthly'),
        ),

        DropdownMenuItem(
          value: 'Yearly',
          child: Text('Yearly'),
        ),
      ],

      onChanged: (value) {
        ref
            .read(
          selectedReportFilterProvider
              .notifier,
        )
            .state = value!;
      },
    );
  }
}