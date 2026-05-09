import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupService {
  Future<String> getDatabasePath() async {
    final dir =
    await getApplicationDocumentsDirectory();

    return p.join(
      dir.path,
      'inventory.sqlite',
    );
  }

  Future<void> backupDatabase() async {
    final dbPath =
    await getDatabasePath();

    final dbFile = File(dbPath);

    if (!await dbFile.exists()) {
      return;
    }

    final output =
    await FilePicker.platform.saveFile(
      dialogTitle:
      'Save Database Backup',
      fileName:
      'inventory_backup.sqlite',
    );

    if (output == null) {
      return;
    }

    await dbFile.copy(output);
  }

  Future<void> restoreDatabase() async {
    final result =
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'sqlite',
      ],
    );

    if (result == null) {
      return;
    }

    final backupFile = File(
      result.files.single.path!,
    );

    final dbPath =
    await getDatabasePath();

    final dbFile = File(dbPath);

    await backupFile.copy(dbPath);

    if (await dbFile.exists()) {}
  }
}