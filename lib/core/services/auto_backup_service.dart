import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AutoBackupService {
  Future<void> createAutoBackup() async {
    final appDir =
    await getApplicationDocumentsDirectory();

    final dbPath = p.join(
      appDir.path,
      'inventory.sqlite',
    );

    final dbFile = File(dbPath);

    if (!await dbFile.exists()) {
      return;
    }

    final backupDir = Directory(
      p.join(
        appDir.path,
        'auto_backups',
      ),
    );

    if (!await backupDir.exists()) {
      await backupDir.create(
        recursive: true,
      );
    }

    final timestamp =
    DateFormat(
      'yyyy_MM_dd_HH_mm',
    ).format(DateTime.now());

    final backupPath = p.join(
      backupDir.path,
      'backup_$timestamp.sqlite',
    );

    await dbFile.copy(backupPath);
  }
}