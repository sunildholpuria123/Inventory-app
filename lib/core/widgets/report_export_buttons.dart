import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/services/csv_export_service.dart';

import '../../../core/services/excel_export_service.dart';

import '../../../core/services/pdf_report_service.dart';
import '../../presentation/sales/provider/sales_history_provider.dart' show salesHistoryProvider;

class ReportExportButtons
    extends ConsumerWidget {
  const ReportExportButtons({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final invoices =
    ref.watch(
      salesHistoryProvider,
    );

    return invoices.when(
      data: (items) {
        return Row(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await ExcelExportService
                    .exportSalesReport(
                  invoices: items,
                );
              },

              icon: const Icon(
                Icons.table_chart,
              ),

              label: const Text(
                'Excel',
              ),
            ),

            const SizedBox(
              width: 20,
            ),

            ElevatedButton.icon(
              onPressed: () async {
                await CsvExportService
                    .exportSalesCsv(
                  invoices: items,
                );
              },

              icon: const Icon(
                Icons.file_copy,
              ),

              label: const Text(
                'CSV',
              ),
            ),

            const SizedBox(
              width: 20,
            ),

            ElevatedButton.icon(
              onPressed: () async {
                await PdfReportService
                    .exportSalesPdf(
                  invoices: items,
                );
              },

              icon: const Icon(
                Icons.picture_as_pdf,
              ),

              label: const Text(
                'PDF',
              ),
            ),
          ],
        );
      },

      loading: () =>
      const CircularProgressIndicator(),

      error: (e, _) =>
          Text(e.toString()),
    );
  }
}