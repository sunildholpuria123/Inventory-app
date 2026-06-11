import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupPathHelper {
  static Future<Directory> getBackupDirectory() async {
    Directory baseDir;

    if (Platform.isAndroid || Platform.isIOS) {
      // App-specific storage
      baseDir = await getApplicationDocumentsDirectory();
    } else {
      // Windows / Linux / macOS
      baseDir = await getApplicationDocumentsDirectory();
    }

    final backupDir = Directory(
      p.join(baseDir.path, 'backups'),
    );

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }
}