import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DatabaseExportService {
  Future<File> exportDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();

    final dbFile = File(p.join(appDir.path, 'inventory.sqlite'));

    return dbFile;
  }
}
