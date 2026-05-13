import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class ExportService {
  static Future<Directory>
  getExportDirectory() async {
    final appDir =
    await getApplicationDocumentsDirectory();

    final exportDir =
    Directory(
      p.join(
        appDir.path,
        'InventoryERP',
        'Exports',
      ),
    );

    if (!await exportDir.exists()) {
      await exportDir.create(
        recursive: true,
      );
    }

    return exportDir;
  }
}