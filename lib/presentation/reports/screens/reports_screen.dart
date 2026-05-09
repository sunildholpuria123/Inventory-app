import 'package:flutter/material.dart';

import '../widgets/profit_chart.dart';
import '../widgets/report_export_service.dart';
import '../widgets/report_filter.dart';
import '../widgets/report_kpi_cards.dart';
import '../widgets/sales_chart.dart';

class ReportsScreen
    extends StatelessWidget {
  const ReportsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [
                Text(
                  'Reports & Analytics',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),

                const ReportFilter(),
              ],
            ),

            const SizedBox(height: 20),

            const ReportKpiCards(),

            const SizedBox(height: 20),

            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: SalesChart(),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      children: const [
                        Expanded(
                          child:
                          ProfitChart(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final service =
                ReportExportService();

                await service.exportReport();
              },

              icon:
              const Icon(Icons.download),

              label: const Text(
                'Export Report',
              ),
            ),

          ],
        ),
      ),
    );
  }
}