import 'dart:io';
import 'package:archive/archive_io.dart' show ZipFileEncoder, extractFileToDisk;

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupService {
  /// ERP ROOT
  static Future<Directory> getBackupDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();

    final backupDir = Directory(p.join(appDir.path, 'InventoryERP', 'Backups'));

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }

  Future<String> getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();

    return p.join(dir.path, 'inventory.sqlite');
  }

  static Future<File>
  getDatabaseFile() async {
    final appDir =
    await getApplicationDocumentsDirectory();

    return File(
      p.join(
        appDir.path,
        'inventory.sqlite',
      ),
    );
  }

  Future<void> backupDatabase() async {
    final dbPath = await getDatabasePath();

    final dbFile = File(dbPath);

    if (!await dbFile.exists()) {
      return;
    }

    final output = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Database Backup',
      fileName: 'inventory_backup.sqlite',
    );

    if (output == null) {
      return;
    }

    await dbFile.copy(output);
  }

  Future<void> restoreDatabase() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['sqlite'],
    );

    if (result == null) {
      return;
    }

    final backupFile = File(result.files.single.path!);

    final dbPath = await getDatabasePath();

    final dbFile = File(dbPath);

    await backupFile.copy(dbPath);

    if (await dbFile.exists()) {}
  }

  /// CREATE ZIP BACKUP
  static Future<File> createBackup() async {
    final dbFile = await getDatabaseFile();

    final backupDir = await getBackupDirectory();

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final zipPath = p.join(backupDir.path, 'backup_$timestamp.zip');

    final encoder = ZipFileEncoder();

    encoder.create(zipPath);

    encoder.addFile(dbFile);

    encoder.close();

    return File(zipPath);
  }

  /// RESTORE BACKUP
  static Future<void> restoreBackup(
      File zipFile,
      ) async {
    final tempDir =
    await getTemporaryDirectory();

    extractFileToDisk(
      zipFile.path,
      tempDir.path,
    );

    final extractedDb = File(
      p.join(
        tempDir.path,
        'inventory.sqlite',
      ),
    );

    final originalDb =
    await getDatabaseFile();

    if (await extractedDb.exists()) {
      await extractedDb.copy(
        originalDb.path,
      );
    }
  }
}
