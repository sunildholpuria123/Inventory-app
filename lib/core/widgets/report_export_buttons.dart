import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/services/csv_export_service.dart';
import '../../../core/services/excel_export_service.dart';
import '../../../core/services/pdf_report_service.dart';
import '../../presentation/sales/provider/sales_history_provider.dart';

class ReportExportButtons extends ConsumerStatefulWidget {
  const ReportExportButtons({super.key});

  @override
  ConsumerState<ReportExportButtons> createState() =>
      _ReportExportButtonsState();
}

class _ReportExportButtonsState
    extends ConsumerState<ReportExportButtons> {
  bool _loading = false;

  Future<void> _shareFile(File file) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: "Sales Report",
        text: "Inventory ERP Sales Report",
      ),
    );
  }

  Future<void> _performAction(
      Future<File> Function() generator,
      bool share,
      ) async {
    try {
      setState(() => _loading = true);

      final file = await generator();

      if (share) {
        await _shareFile(file);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Report exported successfully\n${file.path}',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  PopupMenuButton<String> _buildButton({
    required String label,
    required IconData icon,
    required Future<File> Function() generator,
  }) {
    return PopupMenuButton<String>(
      enabled: !_loading,
      onSelected: (value) {
        switch (value) {
          case 'export':
            _performAction(generator, false);
            break;

          case 'share':
            _performAction(generator, true);
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'export',
          child: Row(
            children: [
              Icon(Icons.download),
              SizedBox(width: 12),
              Text('Export'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              Icon(Icons.share),
              SizedBox(width: 12),
              Text('Share'),
            ],
          ),
        ),
      ],
      child: FilledButton.icon(
        onPressed: null,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invoices = ref.watch(salesHistoryProvider);

    final isMobile = MediaQuery.of(context).size.width < 700;

    return invoices.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),

      error: (e, _) => Text(e.toString()),

      data: (items) {
        final buttons = [
          _buildButton(
            label: "PDF",
            icon: Icons.picture_as_pdf,
            generator: () => PdfReportService.exportSalesPdf(
              invoices: items,
              openAfterExport: true,
            ),
          ),
          _buildButton(
            label: "Excel",
            icon: Icons.table_chart,
            generator: () => ExcelExportService.exportSalesReport(
              invoices: items,
              openAfterExport: true,
            ),
          ),
          _buildButton(
            label: "CSV",
            icon: Icons.description,
            generator: () => CsvExportService.exportSalesCsv(
              invoices: items,
              openAfterExport: true,
            ),
          ),
        ];

        return Stack(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.start,
              children: buttons,
            ),

            if (_loading)
              Positioned.fill(
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}